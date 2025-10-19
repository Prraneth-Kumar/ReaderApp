//
//  ArticleCell.swift
//  ReaderApp
//
//  Created by Prraneth on 19/10/25.
//

import UIKit
import SDWebImage

class ArticleCell: UITableViewCell {
    static let identifier = "ArticleCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        thumbnailImageView.contentMode = .scaleAspectFill
        thumbnailImageView.clipsToBounds = true
    }
    
    func configure(with article: Article) {
        titleLabel.text = article.title
        authorLabel.text = article.author ?? "Unknown"
        if let urlString = article.urlToImage, let url = URL(string: urlString) {
            thumbnailImageView.sd_setImage(with: url, placeholderImage: UIImage(systemName: "photo"))
        } else {
            thumbnailImageView.image = UIImage(systemName: "photo")
        }
    }
}
