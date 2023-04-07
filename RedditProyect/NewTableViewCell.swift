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
        let numberOfComments: String
        let isUnread: Bool
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
    
    private lazy var numberOfCommentsLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var unreadStatusView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var unreadStatusLabel: UILabel = {
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
        numberOfCommentsLabel.text = viewModel.numberOfComments
        unreadStatusView.backgroundColor = viewModel.isUnread ? .green : .red
        unreadStatusLabel.text = viewModel.isUnread ? "Unread" : "Read"
        
        if let thumbnail = viewModel.thumbnail {
            showThumbnail(picture: thumbnail)
        }
    }
    
    func showThumbnail(picture: String) {
    }
    
    func setup() {
        thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        numberOfCommentsLabel.translatesAutoresizingMaskIntoConstraints = false
        unreadStatusView.translatesAutoresizingMaskIntoConstraints = false
        unreadStatusLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(thumbnailImageView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(authorLabel)
        self.contentView.addSubview(dateLabel)
        self.contentView.addSubview(numberOfCommentsLabel)
        self.contentView.addSubview(unreadStatusView)
        unreadStatusView.addSubview(unreadStatusLabel)

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

            unreadStatusView.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 20),
            unreadStatusView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 15),
            unreadStatusView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -15),
            unreadStatusView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -20),
            
            unreadStatusLabel.topAnchor.constraint(equalTo: unreadStatusView.topAnchor, constant: 5),
            unreadStatusLabel.leadingAnchor.constraint(equalTo: unreadStatusView.leadingAnchor, constant: 15),
            unreadStatusLabel.trailingAnchor.constraint(equalTo: unreadStatusView.trailingAnchor, constant: -15),
            unreadStatusLabel.bottomAnchor.constraint(equalTo: unreadStatusView.bottomAnchor, constant: -5)
        ])
    }
}
