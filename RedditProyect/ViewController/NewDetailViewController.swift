//
//  NewDetailViewController.swift
//  RedditProyect
//
//  Created by Vanesa Korbenfeld on 11/04/2023.
//

import UIKit

class NewDetailViewController: UIViewController {
    struct ViewModel {
        let id: String
        let thumbnail: String?
        let title: String
        let author: String
        let date: Date
        let detail: String
    }
    
    private lazy var thumbnailConstraints = [
        thumbnailImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
        thumbnailImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
        thumbnailImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15),
        thumbnailImageView.heightAnchor.constraint(equalToConstant: 200),
        descriptionLabel.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 20),
    ]
    
    private lazy var withoutThumbnailConstraint =                         descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20)
    
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
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(14)
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        authorLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(authorLabel)
        self.view.addSubview(dateLabel)
        self.view.addSubview(titleLabel)
        self.view.addSubview(thumbnailImageView)
        self.view.addSubview(descriptionLabel)

        NSLayoutConstraint.activate([self.withoutThumbnailConstraint])
        NSLayoutConstraint.deactivate(self.thumbnailConstraints)
        
        NSLayoutConstraint.activate([
            authorLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20),
            authorLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            
            dateLabel.centerYAnchor.constraint(equalTo: authorLabel.centerYAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: self.authorLabel.trailingAnchor, constant: 10),
            dateLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15),
            
            titleLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 15),
            titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            descriptionLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 10),
            descriptionLabel.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -15)
        ])
    }
    
}
