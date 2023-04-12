//
//  FullScreenPictureViewController.swift
//  RedditProyect
//
//  Created by Vanesa Korbenfeld on 12/04/2023.
//

import UIKit

class FullScreenViewController: UIViewController {
    struct ViewModel {
        let thumbnail: String
    }
    
    private lazy var thumbnailImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var blackBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(displayP3Red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backgroundTapped)))
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func render(viewModel: ViewModel) {
        showThumbnail(viewModel: FullScreenViewController.ViewModel(thumbnail: viewModel.thumbnail))
    }
    
    @objc func backgroundTapped() {
        self.dismiss(animated: true)
    }
    
    private func showThumbnail(viewModel: ViewModel) {
        thumbnailImageView.download(from: viewModel.thumbnail, completionHandler: { image in
            UIImageView.transition(with: self.thumbnailImageView, duration: 0.5, options: [.curveEaseOut, .transitionCrossDissolve], animations: {
                self.thumbnailImageView.image = image
                self.thumbnailImageView.clipsToBounds = true
            })
        })
    }
    
    private func setup() {
        thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        blackBackgroundView.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(blackBackgroundView)
        self.view.addSubview(thumbnailImageView)

        NSLayoutConstraint.activate([
            blackBackgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            blackBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blackBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            blackBackgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            thumbnailImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            thumbnailImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            thumbnailImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
