//
//  ArticleViewModel.swift
//  ReaderApp
//
//  Created by Prraneth on 19/10/25.
//

import Foundation
import RealmSwift

class ArticleViewModel {
    private let realm = try! Realm()
    private(set) var articles: [Article] = []
    
    var onUpdate: (() -> Void)?
    
    func fetchArticles(for searchData: String = "tata") {
        ArticleService.shared.fetchArticles(for: searchData) { [weak self] result in
            switch result {
            case .success(let articles):
                DispatchQueue.main.async {
                    self?.saveToRealm(articles) // Realm write safe on main thread
                    self?.articles = articles    // safe for UI
                    self?.onUpdate?()
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self?.loadFromRealm()
                }
            }
        }
    }
    func refreshArticles() {
        fetchArticles()
    }
    
    func saveToRealm(_ articles: [Article]) {
        let realm = try! Realm()
        try! realm.write {
            for article in articles {
                // Check if already exists in Realm
                if let existing = realm.object(ofType: Article.self, forPrimaryKey: article.title) {
                    // Preserve bookmark
                    article.isBookmarked = existing.isBookmarked
                }
                realm.add(article, update: .modified)
            }
        }
    }
    
    func loadFromRealm() {
        let savedArticles = realm.objects(Article.self)
        self.articles = Array(savedArticles)
        self.onUpdate?()
    }
    
    func searchArticles(query: String) {
        if query.isEmpty {
            loadFromRealm()
        } else {
            let results = realm.objects(Article.self).filter("title CONTAINS[c] %@", query)
            self.articles = Array(results)
            self.onUpdate?()
        }
    }
    
    func toggleBookmark(article: Article) {
        do {
            try realm.write {
                article.isBookmarked.toggle()
            }
            onUpdate?()
        } catch {
            print("Bookmark Error: \(error)")
        }
    }
    
    func bookmarkedArticles() -> [Article] {
        let bookmarks = realm.objects(Article.self).filter("isBookmarked == true")
        return Array(bookmarks)
    }
}
