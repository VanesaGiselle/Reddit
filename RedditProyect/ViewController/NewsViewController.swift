//
//  NewsViewController.swift
//  RedditProyect
//
//  Created by Vanesa Korbenfeld on 07/04/2023.
//

import UIKit

class NewsViewController: UIViewController {
    private var news: [New] = []
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(NewTableViewCell.self, forCellReuseIdentifier: NewTableViewCell.reuseIdentifier)
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
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(tableView)
        
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
                    self.news.append(New(thumbnail: new.data.preview.images.first?.source.url, title: new.data.title, author: new.data.author, date: "", numComments: new.data.numComments, visited: new.data.visited))
                }
                self.tableView.reloadData()
            case .failure(let error):
                //TODO: handle error
                break
            }
        }, limit: "10")
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
            thumbnail: new.thumbnail,
            title: new.title,
            author: new.author,
            date: new.date ?? "",
            numComments: new.numComments,
            visited: new.visited
        )
        
        tableViewCell.render(viewModel: viewModel)
        return tableViewCell
    }
}
