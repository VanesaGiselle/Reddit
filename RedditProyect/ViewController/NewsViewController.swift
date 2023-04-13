//
//  NewsViewController.swift
//  RedditProyect
//
//  Created by Vanesa Korbenfeld on 07/04/2023.
//

import UIKit

class NewsViewController: UIViewController {
    private var news: [New] = []
    private var currentPage = 1
    private var totalPages = 1
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        return refreshControl
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(NewTableViewCell.self, forCellReuseIdentifier: NewTableViewCell.reuseIdentifier)
        tableView.register(LoadingTableViewCell.self, forCellReuseIdentifier: LoadingTableViewCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getNews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        view.backgroundColor = .white
        
        refreshControl.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(tableView)
        tableView.addSubview(refreshControl)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    private func getNews() {
        HttpConnector().getNews(completionHandler: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let reddit):
                for new in reddit.data.children {
                    self.news.append(New(id: new.data.id, thumbnail: new.data.thumbnail, title: new.data.title, author: new.data.author, date: "", numComments: new.data.numComments))
                }
                self.tableView.reloadData()
            case .failure(let error):
                //TODO: handle error
                break
            }
        }, limit: "10")
    }
    
    @objc func pullToRefresh() {
        refreshControl.endRefreshing()
        getNews()
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
    
//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//
//        if ((tableView.contentOffset.y + tableView.frame.size.height) >= tableView.contentSize.height)
//        {
//             DispatchQueue.main.async {
//                 self.getNextPage()
//             }
//        }
//    }
}
