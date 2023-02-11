//
//  SearchScreen.swift
//  ReduxWithSwiftUI
//
//  Created by Vinay Devdikar on 28/01/23.
//

import SwiftUI

struct SearchScreen: View {
    @State var serachText: String = ""
    @EnvironmentObject var store: AppStore
    var body: some View {
        NavigationView {
            if store.state.isLoading {
                ZStack {
                    ProgressView(value: /*@START_MENU_TOKEN@*/0.5/*@END_MENU_TOKEN@*/)
                        .progressViewStyle(.circular)
                        .tint(.red)
                }
            }
            
            VStack {
                TextField("Enter github username", text: $serachText)
                    .padding([.leading, .trailing], Constant.baseUnit * 2.0)
                    .padding([.top, .bottom], Constant.baseUnit)
                    .multilineTextAlignment(.leading)
                    .onSubmit {
                        store.send(.activateSpinner(status: true))
                        store.send(.search(query: serachText))
                    }
                List {
                    ForEach(store.state.searchResult) { result in
                        UserDetails(userName: result.fullName,
                                    language: result.language ?? "",
                                    numberOfRepos: result.forksCount)
                    }
                }
            }
            .navigationTitle("Home")
        }.navigationViewStyle(.stack)
    }
}

struct SearchScreen_Previews: PreviewProvider {
    static var previews: some View {
        SearchScreen()
    }
}

enum Constant {
    static let baseUnit: CGFloat = 8.0
    static let insets = EdgeInsets(top: 10.0, leading: 16.0, bottom: 8.0, trailing: 16.0)
}

struct UserDetails: View {
    let userName: String
    let language: String
    let numberOfRepos: Int
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 8.0) {
                Text(userName)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.leading)
                    .font(.title)
                    .padding(.leading, 0.0)
                    .lineLimit(0)
                Text("Total Repos: \(numberOfRepos)")
                    .fontWeight(.light)
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.leading)
                    .font(.body)
                    .padding(.leading, 0.0)
                    .lineLimit(0)
                Text(language)
                    .fontWeight(.light)
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.leading)
                    .font(.footnote)
                    .padding(.leading, 0.0)
                    .lineLimit(0)
            }
            Spacer()
            Image(systemName: "chevron.right")
        }
    }
    
}
