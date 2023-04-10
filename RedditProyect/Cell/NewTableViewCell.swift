//
//  NewTableViewCell.swift
//  RedditProyect
//
//  Created by Vanesa Korbenfeld on 07/04/2023.
//

import UIKit

class NewTableViewCell: UITableViewCell {
    struct ViewModel {
        let thumbnail: String?
        let title: String
        let author: String
        let date: String
        let numComments: Int
        let visited: Bool
    }
    
    static var reuseIdentifier = "NewTableViewCell"
    
    private lazy var thumbnailImageView: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var numCommentsLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var visitedStatusView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var visitedStatusLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func render(viewModel: ViewModel) {
        titleLabel.text = viewModel.title
        authorLabel.text = viewModel.author
        dateLabel.text = viewModel.date
        numCommentsLabel.text = String(viewModel.numComments)
        visitedStatusView.backgroundColor = !viewModel.visited ? .green : .red
        visitedStatusLabel.text = !viewModel.visited ? "Unread" : "Read"
        
        if let thumbnail = viewModel.thumbnail {
            showThumbnail(picture: thumbnail)
        }
    }
    
    private func showThumbnail(picture: String) {
    }
    
    private func setup() {
        thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        numCommentsLabel.translatesAutoresizingMaskIntoConstraints = false
        visitedStatusView.translatesAutoresizingMaskIntoConstraints = false
        visitedStatusLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(thumbnailImageView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(authorLabel)
        self.contentView.addSubview(dateLabel)
        self.contentView.addSubview(numCommentsLabel)
        self.contentView.addSubview(visitedStatusView)
        visitedStatusView.addSubview(visitedStatusLabel)

        NSLayoutConstraint.activate([
            thumbnailImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),
            thumbnailImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 15),
            thumbnailImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -15),
            thumbnailImageView.heightAnchor.constraint(equalToConstant: 200),
            
            titleLabel.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -15),
            
            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            authorLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 15),
            authorLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -15),
            
            dateLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 20),
            dateLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 15),
            dateLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -15),

            visitedStatusView.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 20),
            visitedStatusView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 15),
            visitedStatusView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -15),
            visitedStatusView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -20),
            
            visitedStatusLabel.topAnchor.constraint(equalTo: visitedStatusView.topAnchor, constant: 5),
            visitedStatusLabel.leadingAnchor.constraint(equalTo: visitedStatusView.leadingAnchor, constant: 15),
            visitedStatusLabel.trailingAnchor.constraint(equalTo: visitedStatusView.trailingAnchor, constant: -15),
            visitedStatusLabel.bottomAnchor.constraint(equalTo: visitedStatusView.bottomAnchor, constant: -5)
        ])
    }
}
