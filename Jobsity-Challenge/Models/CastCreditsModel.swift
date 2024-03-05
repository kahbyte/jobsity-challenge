//
//  CastCreditsModel.swift
//  Jobsity-Challenge
//
//  Created by Kauê Sales on 04/03/24.
//

import Foundation

struct CastCreditsModel: Codable {
    let embedded: PersonEmbedded
    
    enum CodingKeys: String, CodingKey {
        case embedded = "_embedded"
    }
}
