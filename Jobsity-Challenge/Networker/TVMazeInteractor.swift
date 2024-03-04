//
//  SomeInteractor.swift TODO: Find a better name
//  Jobsity-Challenge
//
//  Created by Kauê Sales on 03/03/24.
//

import Foundation
import Combine

final class TVMazeInteractor {
    private let apiClient: Request
    
    init(apiClient: Request = APIClient()) {
        self.apiClient = apiClient
    }
    
    func fetchShowList(page: Int) -> AnyPublisher<[ShowDetailsModel], Error> {
        guard page > 0 else {
            return Fail(error: APIError.invalidPage).eraseToAnyPublisher() 
        }
        
        guard let url = TVMazeEndpoints.shows.url,
              let paginatedURL = url.appendingQueryItem(name: "page", value: "\(page)")
        else {
            return Fail(error: APIError.invalidURL).eraseToAnyPublisher()
        }

        return apiClient.fetch(from: paginatedURL, as: [ShowDetailsModel].self)
    }
    
    func fetchShowDetails(showId: Int) -> AnyPublisher<ShowDetailsModel, Error> {
        guard let url = TVMazeEndpoints.showDetails(showId: showId).url else {
            return Fail(error: APIError.invalidURL).eraseToAnyPublisher()
        }
        
        return apiClient.fetch(from: url, as: ShowDetailsModel.self)
    }
}
