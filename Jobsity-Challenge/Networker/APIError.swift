//
//  APIError.swift
//  Jobsity-Challenge
//
//  Created by Kauê Sales on 03/03/24.
//

import Foundation

enum APIError: Error, Equatable {
    case invalidPage
    case invalidURL
    case invalidResponse
    case decodingError
    case serverError(String)
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidPage:
            return NSLocalizedString("Invalid Page", comment: "")
        case .invalidURL:
            return NSLocalizedString("Invalid URL", comment: "")
        case .invalidResponse:
            return NSLocalizedString("Invalid Response", comment: "")
        case .decodingError:
            return NSLocalizedString("Decoding Error", comment: "")
        case .serverError(let message):
            return NSLocalizedString("Server Error: \(message)", comment: "")
        }
    }
}
