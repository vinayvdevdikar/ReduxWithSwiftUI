//
//  SearchScreenAction.swift
//  ReduxWithSwiftUI
//
//  Created by Vinay Devdikar on 28/01/23.
//

import Foundation
enum AppAction {
    case setSearchResults(repos: [UserList])
    case search(query: String)
    case activateSpinner(status: Bool)
}
