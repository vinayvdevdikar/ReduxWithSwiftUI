//
//  GithubService.swift
//  ReduxWithSwiftUI
//
//  Created by Vinay Devdikar on 11/02/23.
//

import Foundation
import Combine

struct SearchResponse: Decodable {
    let items: [UserList]
}

class GithubService {
    private let session: URLSession
    private let decoder: JSONDecoder

    init(session: URLSession = .shared, decoder: JSONDecoder = .init()) {
        self.session = session
        self.decoder = decoder
    }

    func searchPublisher(matching query: String) -> AnyPublisher<[UserList], Error> {
        guard
            let url = URL(string: "https://api.github.com/users/\(query)/repos")
            else { preconditionFailure("Can't create url from url components...")  }

        return session
            .dataTaskPublisher(for: url)
            .tryMap({ [weak self] (data, response) -> [UserList] in
                do {
                    let list = try self?.decoder.decode([UserList].self, from: data)
                    return list ?? []
                }catch {
                    print(error)
                }
                return []
            })
            .eraseToAnyPublisher()
    }
}
