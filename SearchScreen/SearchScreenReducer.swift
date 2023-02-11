//
//  SearchScreenReducer.swift
//  ReduxWithSwiftUI
//
//  Created by Vinay Devdikar on 28/01/23.
//

import Foundation
import Combine

struct AppState {
    var searchResult: [UserList] = []
    var isLoading: Bool = false
}

struct Services {
    var service = GithubService()
}

func appReducer( state: inout AppState, action: AppAction, environment: Services) -> AnyPublisher<AppAction, Never> {
    switch action {
    case .search(let query):
        state.searchResult = []
        return environment.service.searchPublisher(matching: query)
            .replaceError(with: [])
            .map { AppAction.setSearchResults(repos: $0) }
            .eraseToAnyPublisher()
    case .setSearchResults(let repos):
        state.isLoading = false
        state.searchResult = repos
    case .activateSpinner(let status):
        state.isLoading = status
    }
    return Empty().eraseToAnyPublisher()
}
