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
        let description: String
    }
    
    private var viewModel: ViewModel?
    
    private lazy var thumbnailConstraints = [
        thumbnailImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
        thumbnailImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
        thumbnailImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15),
        thumbnailImageView.heightAnchor.constraint(equalToConstant: 200),
        descriptionLabel.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 20),
    ]
    
    private lazy var withoutThumbnailConstraint =                         descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20)
    
    private lazy var thumbnailFullScreenImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = UIScreen.main.bounds
        imageView.backgroundColor = UIColor(displayP3Red: 0/255, green: 0/255, blue: 0/255, alpha: 0.7)
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        imageView.addGestureRecognizer(tap)
        return imageView
    }()
    
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
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped)))
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
    
    func readNew(id: String) {
        UserConfiguration().setReadNew(id: id)
    }
    
    @objc func imageTapped(_ sender: UITapGestureRecognizer) {
        guard let imageView = sender.view as? UIImageView else { return }
        thumbnailFullScreenImageView.image = imageView.image
        self.view.addSubview(thumbnailFullScreenImageView)
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }

    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
    }
    
    func render(viewModel: ViewModel) {
        self.viewModel = viewModel
        
        readNew(id: viewModel.id)
        
        if viewModel.thumbnail != nil {
            showThumbnail(viewModel: viewModel)
        }
        
        authorLabel.text = viewModel.author
        titleLabel.text = viewModel.title
        dateLabel.text = Date().getDateInterval(interval: viewModel.date.getDateDifferenceToNow())
        descriptionLabel.text = viewModel.description
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
                })
            } else {
                NSLayoutConstraint.activate([self.withoutThumbnailConstraint])
                NSLayoutConstraint.deactivate(self.thumbnailConstraints)
            }
        })
    }
    
    private func setup() {
        view.backgroundColor = .white
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
            authorLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            authorLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            
            dateLabel.centerYAnchor.constraint(equalTo: authorLabel.centerYAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: self.authorLabel.trailingAnchor, constant: 10),
            dateLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15),
            
            titleLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 15),
            titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15)
        ])
    }
}
