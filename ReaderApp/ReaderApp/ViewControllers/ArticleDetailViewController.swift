//
//  ArticleDetailViewController.swift
//  ReaderApp
//
//  Created by Prraneth on 19/10/25.
//

import UIKit
import SDWebImage

class ArticleDetailViewController: UIViewController {
    
    let article: Article
    let viewModel: ArticleViewModel
    
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let contentLabel = UILabel()
    let bookmarkButton = UIButton(type: .system)
    
    init(article: Article, viewModel: ArticleViewModel) {
        self.article = article
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        configure()
    }
    
    func setupUI() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentLabel.font = .systemFont(ofSize: 16)
        contentLabel.numberOfLines = 0
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        
        bookmarkButton.setTitle("Bookmark", for: .normal)
        bookmarkButton.addTarget(self, action: #selector(toggleBookmark), for: .touchUpInside)
        bookmarkButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(contentLabel)
        view.addSubview(bookmarkButton)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            bookmarkButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            bookmarkButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            
            contentLabel.topAnchor.constraint(equalTo: bookmarkButton.bottomAnchor, constant: 10),
            contentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            contentLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
    }
    
    func configure() {
        titleLabel.text = article.title
        contentLabel.text = article.content ?? "No content available."
        if let urlString = article.urlToImage, let url = URL(string: urlString) {
            imageView.sd_setImage(with: url, placeholderImage: UIImage(systemName: "photo"))
        }
        updateBookmarkButton()
    }
    
    func updateBookmarkButton() {
        bookmarkButton.setTitle(article.isBookmarked ? "Remove Bookmark" : "Bookmark", for: .normal)
    }
    
    @objc func toggleBookmark() {
        viewModel.toggleBookmark(article: article)
        updateBookmarkButton()
    }
}


