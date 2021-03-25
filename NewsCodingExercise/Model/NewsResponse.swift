//
//  NewsResponse.swift
//  NewsCodingExercise
//
//  Created by Suniket Wagh on 24/3/21.
//

import Foundation

/// Response structurefrom server.
struct NewsResponse: Codable {
    
    let status: String?
    
    let feed: Feed
    
    let items: [Item]

}

struct Feed: Codable {
    
    let title: String?
    
    let image: String?
}

struct Item: Codable {
    
    let title: String?
    
    let pubDate: String?
    
    let thumbnail: String?

    let description: String?

    let content: String?

    let enclosure: Enclosure?
    
}

struct Enclosure: Codable {
    
    let link: String?
    
    let type: String?
    
    let thumbnail: String?

}
