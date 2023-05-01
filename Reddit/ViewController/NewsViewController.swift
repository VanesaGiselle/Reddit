//
//  NewsViewController.swift
//  Reddit
//
//  Created by Vanesa Korbenfeld on 07/04/2023.
//

import UIKit

class NewsViewController: UIViewController {
    private var news: [New] = []
    
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
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        return tableView
    }()
    
    private lazy var pagination: Pagination = {
        let pagination = Pagination()
        pagination.onGotNewsForFirstTime = {[weak self] in
            self?.tableView.reloadData()
        }
        
        pagination.newsProvider = HttpConnector()
        return pagination
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getFirstPage()
        setup()
    }
    
    private func getFirstPage() {
        pagination.getFirstPage(onGotNews: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let news):
                self.news = news
                self.tableView.reloadData()
            case .failure(let error):
                self.handleFailure(error)
                break
            }
        })
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
    
    @objc func pullToRefresh() {
        refreshControl.endRefreshing()
        getFirstPage()
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
        tableViewCell.onUpdatedImage = {
            self.tableView.beginUpdates()
            self.tableView.setNeedsDisplay()
            self.tableView.endUpdates()
        }
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
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
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
            self.tableView.tableFooterView = createFooter()
            
            pagination.getNextPage(onGotNews: { [weak self] result, addedNews in
                guard let self = self else { return }
                switch result {
                case .success(let news):
                    self.news = news
                    
                    var indexPaths: [IndexPath] = []
                    for i in (self.news.count - addedNews) ..< self.news.count {
                        indexPaths.append(IndexPath(row: i - 1, section: 0))
                    }
                    self.tableView.performBatchUpdates({
                        self.tableView.insertRows(at: indexPaths
                                                  , with: .bottom)
                    }, completion: nil)
                    
                case .failure(let error):
                    self.handleFailure(error)
                    break
                }
            })
            self.tableView.tableFooterView = nil
        }
    }
}

class Pagination {
    private var newsCount = 0
    private let pageSize = 10
    private var pageSizeInclundingCurrentNews: Int {
        pageSize + newsCount
    }
    var newsProvider: NewsProvider?
    var onGotNewsForFirstTime: (()->())?
    
    init() {}

    func getFirstPage(onGotNews: @escaping(Result<[New], ErrorType>) -> Void) {
        newsCount = 0
        getNextPage(onGotNews: { result, addedNews in
            onGotNews(result)
        })
    }
    
    internal func convertApiNewsToUniqueNews(apiNews: News) -> [New] {
        var news: [New] = []
        for new in apiNews.data.children {
            news.append(New(id: new.data.id, thumbnail: new.data.thumbnail, title: new.data.title, author: new.data.author, numComments: new.data.numComments))
        }
        return news.getUniqueElements()
    }
    
    func getNextPage(onGotNews: @escaping(Result<[New], ErrorType>, Int) -> Void) {
        newsProvider?.getNews(completionHandler: { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let apiData):
                let newNews = self.convertApiNewsToUniqueNews(apiNews: apiData)
                let addedNews = newNews.count - self.newsCount
                self.newsCount = newNews.count
                onGotNews(.success(newNews), addedNews)
            case .failure(let error):
                onGotNews(.failure(error), 0)
                break
            }
            
        }, limit: String(pageSizeInclundingCurrentNews))
    }
}

protocol NewsProvider {
    func getNews(completionHandler: @escaping(Result<News, ErrorType>) -> Void, limit: String?)
}
