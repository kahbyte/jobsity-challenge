//
//  APIClient.swift
//  Jobsity-Challenge
//
//  Created by Kauê Sales on 03/03/24.
//

import Foundation
import Combine

protocol Request {
    func fetch<T: Decodable>(from url: URL, as type: T.Type) -> AnyPublisher<T, Error>
}

final class APIClient: Request {
    private var cancellables = Set<AnyCancellable>()
    private var urlSession: URLSessionProtocol
    
    init(urlSession: URLSessionProtocol = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func fetch<T: Decodable>(
        from url: URL,
        as type: T.Type
    ) -> AnyPublisher<T, Error> {
        return urlSession.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
