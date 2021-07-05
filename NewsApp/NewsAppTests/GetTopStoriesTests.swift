//
//  GetTopStoriesTests.swift
//  NewsAppTests
//
//  Created by Jervy Umandap on 7/5/21.
//

import XCTest
@testable import NewsApp

class GetTopStoriesTests: XCTestCase {
    
    func testCanParseArticlesViaJSONFile() throws {
        guard let pathString = Bundle(for: type(of: self)).path(forResource: "News", ofType: "json") else {
            fatalError("News.json file not found")
        }
        
        print("News.json path:- \(pathString)")
        
        guard let json = try? String(contentsOfFile: pathString, encoding: .utf8) else {
            fatalError("Unable to convert JSON to String")
        }
        
        let jsonData = json.data(using: .utf8)!
        let newsData = try! JSONDecoder().decode(APIResponse.self, from: jsonData)
        
        XCTAssertEqual(newsData.status, "ok")
        XCTAssertEqual(newsData.totalResults, 38)
        
        XCTAssertEqual(newsData.articles.first?.source.name, "The Times of India")
        XCTAssertEqual(newsData.articles.first?.source.id, "the-times-of-india")
        
        XCTAssertEqual(newsData.articles.first?.author, "AP")
        XCTAssertEqual(newsData.articles.first?.title, "A small spacewalk demonstrates a quantum leap in China's extraterrestrial ambitions - ​China's ET ambitions - Economic Times")
        
        XCTAssertEqual(newsData.articles.first?.description, "According to an AFP report, astronauts at China's new space station conducted their first spacewalk July 4, state media reported, as Beijing presses on with its extraterrestrial ambitions. It was only the second time the country's astronauts have stepped out …")
        XCTAssertEqual(newsData.articles.first?.url, "https://economictimes.indiatimes.com/news/science/a-small-spacewalk-demonstrates-a-quantum-leap-in-chinas-extraterrestrial-ambitions/chinas-et-ambitions/slideshow/84137094.cms")
        XCTAssertEqual(newsData.articles.first?.urlToImage, "https://img.etimg.com/thumb/msid-84137094,width-1070,height-580,overlay-economictimes/photo.jpg")
        XCTAssertEqual(newsData.articles.first?.publishedAt, "2021-07-05T08:11:00Z")
        
        
        
    }
    
    func testCanParseArticles() throws {
        
        let json = """
        {
          "status" : "ok",
          "totalResults" : 1,
          "articles" : [
            {
              "source": {
                "id": "google-news",
                "name": "Google News"
              },
              "author": null,
              "title": "Germany - Brazil | Finals | Full Highlights - FIBA Olympic Qualifying Tournament 2020 - FIBA - The Basketball Channel",
              "description": null,
              "url": "https://news.google.com/__i/rss/rd/articles/CBMiK2h0dHBzOi8vd3d3LnlvdXR1YmUuY29tL3dhdGNoP3Y9ZmJvakU3Z0I1d0HSAQA?oc=5",
              "urlToImage": null,
              "publishedAt": "2021-07-05T07:00:09Z",
              "content": null
            }
          ]
        }
        """
        
        let jsonData = json.data(using: .utf8)!
        let newsData = try! JSONDecoder().decode(APIResponse.self, from: jsonData)
        
        XCTAssertEqual(newsData.status, "ok")
        XCTAssertEqual(newsData.totalResults, 1)
        
        XCTAssertEqual(newsData.articles.first?.source.id, "google-news")
        XCTAssertEqual(newsData.articles.first?.source.name, "Google News")
        XCTAssertNil(newsData.articles.first?.author)
        XCTAssertEqual(newsData.articles.first?.title, "Germany - Brazil | Finals | Full Highlights - FIBA Olympic Qualifying Tournament 2020 - FIBA - The Basketball Channel")
        XCTAssertNil(newsData.articles.first?.description)
        XCTAssertEqual(newsData.articles.first?.url, "https://news.google.com/__i/rss/rd/articles/CBMiK2h0dHBzOi8vd3d3LnlvdXR1YmUuY29tL3dhdGNoP3Y9ZmJvakU3Z0I1d0HSAQA?oc=5")
        XCTAssertNil(newsData.articles.first?.urlToImage)
        XCTAssertEqual(newsData.articles.first?.publishedAt, "2021-07-05T07:00:09Z")
        
    }
    
    func testCanParseArticlesWithEmptyAuthor() throws {
        
        let json = """
        {
          "articles" : [
             {
               "author" : null,
               "content" : "Demolition crews have set off explosives to bring down the remaining portion of a partially collapsed apartment building in South Florida, where 24 people have been confirmed dead and 121 remain miss 2026 [+2495 chars]",
               "description" : "Damaged remaining portion of the collapsed Florida condo demolished as rescuers prepare to resume searching for victims.",
               "publishedAt" : "2021-07-05T03:57:28Z",
               "source" : {
                 "id" : "al-jazeera-english",
                 "name" : "Al Jazeera English"
               },
               "title" : "Collapsed Florida condo demolished, search and rescue to resume - Al Jazeera English",
               "url" : "https://www.aljazeera.com/news/2021/7/5/collapsed-florida-condo-demolished-search-and-rescue-to-resume",
               "urlToImage" : "https://www.aljazeera.com/wp-content/uploads/2021/07/063_1327019893.jpg?resize:1200%2C630"
             }
          ],
          "status" : "ok",
          "totalResults" : 1
        }
        """
        
        let jsonData = json.data(using: .utf8)!
        let newsData = try! JSONDecoder().decode(APIResponse.self, from: jsonData)
        
        XCTAssertNil(newsData.articles.first?.author)
        
    }
    
    
}
