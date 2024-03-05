//
//  ShowDetailsModel.swift
//  Jobsity-Challenge
//
//  Created by Kauê Sales on 03/03/24.
//

import Foundation

struct ShowDetailsModel: Codable, Identifiable, Equatable {
    let id: Int?
    let url: String?
    let name: String?
    let type: String?
    let language: String?
    let genres: [String]?
    let status: String?
    let runtime: Int?
    let averageRuntime: Int?
    let premiered: String?
    let ended: String?
    let officialSite: String?
    let schedule: Schedule?
    let rating: Rating?
    let weight: Int?
    let network: Network?
    let webChannel: WebChannel?
    let image: ImageModel?
    let summary: String?
    let updated: Int? 
    let embedded: Embedded?

    enum CodingKeys: String, CodingKey {
        case id, url, name, type, language, genres, status, runtime, averageRuntime, premiered, ended, officialSite, schedule, rating, weight, network, webChannel, image, summary, updated
        case embedded = "_embedded"
    }
    
    static func == (lhs: ShowDetailsModel, rhs: ShowDetailsModel) -> Bool {
        return lhs.id == rhs.id
    }
}

struct Schedule: Codable {
    let time: String?
    let days: [String]?
}

struct Rating: Codable {
    let average: Double?
}

struct Network: Codable {
    let id: Int?
    let name: String?
    let country: Country?
}

struct WebChannel: Codable {
    let id: Int?
    let name: String?
    let country: Country?
    let officialSite: String?
}

struct Country: Codable {
    let name: String?
    let code: String?
    let timezone: String?
}

struct Externals: Codable {
    let tvrage: Int?
    let thetvdb: Int?
    let imdb: String?
}

struct ImageModel: Codable {
    let medium: String?
    let original: String?
}

struct Links: Codable {
    let selfLink: SelfLink?
    let previousepisode: Previousepisode?

    enum CodingKeys: String, CodingKey {
        case selfLink = "self"
        case previousepisode
    }
}

struct SelfLink: Codable {
    let href: String?
}

struct Previousepisode: Codable {
    let href: String?
}

struct Embedded: Codable {
    let cast: [Cast]?
}

struct PersonEmbedded: Codable {
    let show: ShowDetailsModel?
}

struct Cast: Codable, Identifiable{
    var id: Int { person.id ?? 0 }
    let person: Person
    let character: Character?
}

struct Person: Codable, Identifiable {
    let id: Int?
    let url: String?
    let name: String?
    let country: Country?
    let birthday: String?
    let deathday: String?
    let gender: String?
    let image: ImageModel?
}

struct Character: Codable {
    let id: Int?
    let name: String?
    let image: ImageModel?
}
