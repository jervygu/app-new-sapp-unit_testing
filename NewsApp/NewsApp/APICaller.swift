//
//  APICaller.swift
//  NewsApp
//
//  Created by Jervy Umandap on 5/25/21.
//

import Foundation

final class APICaller {
    static let shared = APICaller()
    
    struct Constants {
        static let topHeadlines = URL(string: "https://newsapi.org/v2/top-headlines?country=ph&apiKey=76f2c4b09de5439c95e0abc9de4fb7f5")
    }
    
    private init() {}
    
    public func getTopStories(completion: @escaping(Result<[Article], Error>) -> Void) {
        guard let url = Constants.topHeadlines else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
//                    let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    print("APIresponse: \(result)")
//                    print("Articles: \(result.articles.count)")
                    completion(.success(result.articles))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}

// Models

struct APIResponse: Codable {
    let articles: [Article]

    let status: String
    let totalResults: Int
}

struct Article: Codable {
    let source: Source
    let title: String
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String
    let author: String?
}

struct Source: Codable {
    let id: String?
    let name: String
}
