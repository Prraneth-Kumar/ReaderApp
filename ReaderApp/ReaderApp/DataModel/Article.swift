//
//  Article.swift
//  ReaderApp
//
//  Created by Prraneth on 19/10/25.
//

import Foundation
import RealmSwift

class Article: Object, Codable {
    @objc dynamic var title: String = ""
    @objc dynamic var author: String? = ""
    @objc dynamic var urlToImage: String? = ""
    @objc dynamic var content: String? = ""
    @objc dynamic var isBookmarked: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case title, author, content
        case urlToImage = "urlToImage"
    }
    
    override class func primaryKey() -> String? {
        return "title"
    }
}

