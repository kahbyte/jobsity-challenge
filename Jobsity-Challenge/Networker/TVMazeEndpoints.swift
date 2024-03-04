//
//  APIEndpoint.swift
//  Jobsity-Challenge
//
//  Created by Kauê Sales on 03/03/24.
//

import Foundation

enum TVMazeEndpoints {
    case shows
    case showDetails(showId: Int)
    
    var path: String {
        switch self {
        case .shows:
            return "/shows"
        case .showDetails(let showId):
            return "/shows/\(showId)"
        }
    }
    
    var url: URL? {
        let baseUrl = "https://api.tvmaze.com"
        return URL(string: baseUrl + path)
    }
}
