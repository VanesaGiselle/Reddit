//
//  NewsViewController.swift
//  RedditProyect
//
//  Created by Vanesa Korbenfeld on 07/04/2023.
//

import UIKit

class NewsViewController: UIViewController {
    private var news: [New] = []
    private var start = 10
    
    private lazy var dismissAllButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(dismissAllTapped), for: .touchUpInside)
        button.setTitle("Dismiss all", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        return refreshControl
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(NewTableViewCell.self, forCellReuseIdentifier: NewTableViewCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getNews(pagination: false, limit: start)
        setup()
    }
    
    private func createFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 50))
        let activityIndicator = UIActivityIndicatorView()
        
        footerView.addSubview(activityIndicator)
        activityIndicator.center = footerView.center
        activityIndicator.startAnimating()
        return footerView
    }
    
    private func setup() {
        view.backgroundColor = .white
        
        refreshControl.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        dismissAllButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(dismissAllButton)
        self.view.addSubview(tableView)
        tableView.addSubview(refreshControl)
        
        NSLayoutConstraint.activate([
            dismissAllButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            dismissAllButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            dismissAllButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            dismissAllButton.heightAnchor.constraint(equalToConstant: 25),
            
            tableView.topAnchor.constraint(equalTo: self.dismissAllButton.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    private func getNews(pagination: Bool, limit: Int) {
        HttpConnector().getNews(completionHandler: { [weak self] result in
            guard let self = self else { return }
            self.tableView.tableFooterView = nil

            if pagination {
                HttpConnector().isPagination = false
            }
            switch result {
            case .success(let apiData):
                for new in apiData.data.children {
                    self.news.append(New(id: new.data.id, thumbnail: new.data.thumbnail, title: new.data.title, author: new.data.author, numComments: new.data.numComments))
                }
                self.news = self.news.getUniqueElements()
                if limit == 10 {
                    self.tableView.reloadData()
                } else {
                    DispatchQueue.main.async {
                        var indexPaths: [IndexPath] = []

                        for i in self.start - 10 ..< self.news.count {
                            indexPaths.append(IndexPath(row: i - 1, section: 0))
                        }
                        
                        self.tableView.performBatchUpdates({
                            self.tableView.insertRows(at: indexPaths
                            , with: .bottom)
                           }, completion: nil)
                    }
                }
            case .failure(let error):
                self.handleFailure(error)
                break
            }
        }, limit: String(limit), pagination: pagination)
    }
    
    @objc func pullToRefresh() {
        refreshControl.endRefreshing()
        start = 10
        getNews(pagination: false, limit: start)
    }
    
    @objc func dismissAllTapped() {
        news = []
        UIView.transition(with: tableView,
                          duration: 0.35,
                          options: .transitionCrossDissolve,
                          animations: { self.tableView.reloadData() })
    }
}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tableViewCell = tableView.dequeueReusableCell(withIdentifier: NewTableViewCell.reuseIdentifier, for: indexPath) as? NewTableViewCell else {
            return UITableViewCell()
        }
        let new = news[indexPath.row]
        
        let viewModel = NewTableViewCell.ViewModel(
            id: new.id,
            thumbnail: new.thumbnail,
            title: new.title,
            author: new.author,
            date: new.date,
            numComments: new.numComments,
            read: new.read
        )
        
        tableViewCell.render(viewModel: viewModel)
        return tableViewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)

        let newDetailViewController = NewDetailViewController()
        
        let new = news[indexPath.row]
        let viewModel = NewDetailViewController.ViewModel(
            id: new.id,
            thumbnail: new.thumbnail,
            title: new.title,
            author: new.author,
            date: new.date,
            description: new.description
        )
        newDetailViewController.render(viewModel: viewModel)
        
        self.navigationController?.pushViewController(newDetailViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
        self.news.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
      }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let position = scrollView.contentOffset.y
        
        if position > tableView.contentSize.height - 100 - scrollView.frame.size.height {
            guard !HttpConnector().isPagination else {
                return
            }
            self.tableView.tableFooterView = createFooter()
            start = start + 10
            getNews(pagination: true, limit: start)
        }
    }
}
