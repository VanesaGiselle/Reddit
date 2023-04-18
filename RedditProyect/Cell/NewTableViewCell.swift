//
//  NewTableViewCell.swift
//  RedditProyect
//
//  Created by Vanesa Korbenfeld on 07/04/2023.
//

import UIKit

class NewTableViewCell: UITableViewCell {
    struct ViewModel {
        let id: String
        let thumbnail: String?
        let title: String
        let author: String
        let date: Date
        let numComments: Int
        let read: Bool
    }
    
    static var reuseIdentifier = "NewTableViewCell"
    
    private lazy var thumbnailConstraints = [
        thumbnailImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
        thumbnailImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 15),
        thumbnailImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -15),
        thumbnailImageView.heightAnchor.constraint(equalToConstant: 200),
        numCommentsLabel.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 20),
    ]
    
    private lazy var withoutThumbnailConstraint =                         numCommentsLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20)
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(12)
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(12)
        label.textColor = .gray
        label.textAlignment = .left
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var thumbnailImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var commentImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var numCommentsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    private lazy var readStatusLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.textAlignment = .right
        label.font = UIFont.boldSystemFont(ofSize: 14)
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
        if viewModel.thumbnail != nil {
            showThumbnail(viewModel: viewModel)
        }
        commentImageView.image = UIImage(named: "comment")
        titleLabel.text = viewModel.title
        authorLabel.text = viewModel.author
        dateLabel.text = Date().getDateInterval(interval: viewModel.date.getDateDifferenceToNow())
        numCommentsLabel.text = String(viewModel.numComments)
        readStatusLabel.text = viewModel.read ? "Read" : "Unread"
    }
    
    private func showThumbnail(viewModel: ViewModel) {
        guard let url = viewModel.thumbnail else {
            return
        }
        
        NSLayoutConstraint.activate(self.thumbnailConstraints)
        NSLayoutConstraint.deactivate([self.withoutThumbnailConstraint])
        
        let id = viewModel.id
        thumbnailImageView.download(from: url, completionHandler: { image in
            if id == viewModel.id {
                UIImageView.transition(with: self.thumbnailImageView, duration: 0.5, options: [.curveEaseOut, .transitionCrossDissolve], animations: {
                    self.thumbnailImageView.image = image
                    self.thumbnailImageView.clipsToBounds = true
//                    ImageSaver().writeToPhotoAlbum(image: image)
                })
            } else {
                NSLayoutConstraint.activate([self.withoutThumbnailConstraint])
                NSLayoutConstraint.deactivate(self.thumbnailConstraints)
            }
        })
    }
    
    private func setup() {
        authorLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        numCommentsLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        commentImageView.translatesAutoresizingMaskIntoConstraints = false
        numCommentsLabel.translatesAutoresizingMaskIntoConstraints = false
        readStatusLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(authorLabel)
        self.contentView.addSubview(dateLabel)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(thumbnailImageView)
        self.contentView.addSubview(commentImageView)
        self.contentView.addSubview(numCommentsLabel)
        self.contentView.addSubview(readStatusLabel)

        NSLayoutConstraint.activate([self.withoutThumbnailConstraint])
        NSLayoutConstraint.deactivate(self.thumbnailConstraints)
        
        NSLayoutConstraint.activate([
            authorLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),
            authorLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 15),
            
            dateLabel.centerYAnchor.constraint(equalTo: authorLabel.centerYAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: self.authorLabel.trailingAnchor, constant: 10),
            dateLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -15),
            
            titleLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 15),
            titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -15),
            
            commentImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 15),
            commentImageView.centerYAnchor.constraint(equalTo: self.numCommentsLabel.centerYAnchor),
            commentImageView.heightAnchor.constraint(equalToConstant: 18),
            commentImageView.widthAnchor.constraint(equalTo: commentImageView.heightAnchor),
            
            numCommentsLabel.leadingAnchor.constraint(equalTo: self.commentImageView.trailingAnchor, constant: 10),
            
            readStatusLabel.centerYAnchor.constraint(equalTo: numCommentsLabel.centerYAnchor),
            readStatusLabel.leadingAnchor.constraint(equalTo: numCommentsLabel.trailingAnchor, constant: 15),
            readStatusLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -15),
            readStatusLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -15)
        ])
    }
}
