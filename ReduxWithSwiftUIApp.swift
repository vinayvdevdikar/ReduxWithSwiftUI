//
//  ReduxWithSwiftUIApp.swift
//  ReduxWithSwiftUI
//
//  Created by Vinay Devdikar on 27/01/23.
//

import SwiftUI

@main
struct ReduxWithSwiftUIApp: App {
    let store = AppStore(initialState: .init(), reducer: appReducer, environment: Services())
    
    
    var body: some Scene {
        WindowGroup {
            SearchScreen()
                .environmentObject(store)
        }
    }
}
