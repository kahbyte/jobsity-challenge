//
//  TVMazeInteractor.swift
//  Jobsity-Challenge
//
//  Created by Kauê Sales on 03/03/24.
//

import Foundation
import Combine

protocol TVMazeInteractorProtocol {
    func fetchShowList(page: Int) -> AnyPublisher<[ShowDetailsModel], Error>
    func fetchShowDetails(showId: Int) -> AnyPublisher<ShowDetailsModel, Error>
    func fetchEpisodeList(for showId: Int) -> AnyPublisher<[EpisodeModel], Error>
    func fetchCast(for showId: Int) -> AnyPublisher<[Cast], Error>
    func fetchGuestCast(for episode: Int) -> AnyPublisher<[Cast], Error>
    func fetchAppearances(for personId: Int) -> AnyPublisher<[CastCreditsModel], Error>
    func fetchShowLookup(_ term: String) -> AnyPublisher<[ShowLookupModel], Error>
}

final class TVMazeInteractor: TVMazeInteractorProtocol  {
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
        guard let base = TVMazeEndpoints.showDetails(showId: showId).url,
              let url = base.appendingQueryItem(name: "embed", value: "cast")
        else {
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
    
    func fetchEpisodeList(for showId: Int) -> AnyPublisher<[EpisodeModel], Error> {
        guard let url = TVMazeEndpoints.episodes(showId: showId).url else {
            return Fail(error: APIError.invalidURL).eraseToAnyPublisher()
        }

        return apiClient.fetch(from: url, as: [EpisodeModel].self)
    }
    
    func fetchCast(for showId: Int) -> AnyPublisher<[Cast], Error> {
        guard let url = TVMazeEndpoints.cast(showId: showId).url else {
            return Fail(error: APIError.invalidURL).eraseToAnyPublisher()
        }

        return apiClient.fetch(from: url, as: [Cast].self)
    }
    
    func fetchGuestCast(for episode: Int) -> AnyPublisher<[Cast], Error> {
        guard let url = TVMazeEndpoints.episodeGuestAndCast(episode: episode).url else {
            return Fail(error: APIError.invalidURL).eraseToAnyPublisher()
        }
        
        return apiClient.fetch(from: url, as: [Cast].self)
    }
    
    func fetchAppearances(for personId: Int) -> AnyPublisher<[CastCreditsModel], Error> {
        guard let base = TVMazeEndpoints.personAppearances(personId: personId).url,
              let url = base.appendingQueryItem(name: "embed", value: "show")
        else {
            return Fail(error: APIError.invalidURL).eraseToAnyPublisher()
        }
        
        return apiClient.fetch(from: url, as: [CastCreditsModel].self)
    }
}
