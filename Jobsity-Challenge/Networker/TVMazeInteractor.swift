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
        
        guard let base = TVMazeEndpoints.shows.url,
              let url = base.appendingQueryItem(name: "page", value: "\(page)")
        else {
            return Fail(error: APIError.invalidURL).eraseToAnyPublisher()
        }

        return apiClient.fetch(from: url, as: [ShowDetailsModel].self)
    }
    
    func fetchShowDetails(showId: Int) -> AnyPublisher<ShowDetailsModel, Error> {
        guard let url = TVMazeEndpoints.showDetails(showId: showId).url else {
            return Fail(error: APIError.invalidURL).eraseToAnyPublisher()
        }
        
        return apiClient.fetch(from: url, as: ShowDetailsModel.self)
    }
    
    func fetchShowLookup(_ term: String) -> AnyPublisher<[ShowLookupModel], Error>{
        guard let base = TVMazeEndpoints.searchShows.url,
              let url = base.appendingQueryItem(name: "q", value: "\(term)")
        else {
            return Fail(error: APIError.invalidURL).eraseToAnyPublisher()
        }
        
        return apiClient.fetch(from: url, as: [ShowLookupModel].self)
    }
}
