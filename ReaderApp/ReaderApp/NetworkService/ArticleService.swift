//
//  ArticleService.swift
//  ReaderApp
//
//  Created by Prraneth on 19/10/25.
//

import Foundation

class ArticleService {
    static let shared = ArticleService()
    
    private let apiKey = "bf3b6b7a33834b96bf5e748c41bff8cd"
    
    func fetchArticles(for searchData: String = "tata", completion: @escaping (Result<[Article], Error>) -> Void) {
        let urlString = "https://newsapi.org/v2/everything?q=\(searchData)&from=2025-09-19&sortBy=publishedAt&apiKey=\(apiKey)"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(ArticleResponse.self, from: data)
                completion(.success(response.articles))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
