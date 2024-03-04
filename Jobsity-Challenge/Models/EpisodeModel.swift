//
//  EpisodeModel.swift
//  Jobsity-Challenge
//
//  Created by Kauê Sales on 04/03/24.
//

import Foundation

struct EpisodeModel: Decodable, Identifiable {
    let id: Int?
    let url: String?
    let name: String?
    let season: Int?
    let number: Int?
    let type: String?
    let airdate: String?
    let airtime: String?
    let airstamp: String?
    let runtime: Int?
    let rating: Rating?
    let image: ImageModel?
    let summary: String?
    let links: Links?
    
    enum CodingKeys: String, CodingKey {
        case id, url, name, season, number, type, airdate, airtime, airstamp, runtime, rating, image, summary
        case links = "_links"
    }
}
