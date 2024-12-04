//
//  ContentView.swift
//  MovieDatatbaseCompanion
//
//  Created by Paul Ehrhardt on 29/11/24.
//

import SwiftUI


// MARK: - ContentView -

struct ContentView: View {
    
    
    // MARK: - Properties

    @State var selection: MenuItem? = MenuItem.menuItems.first

    
    // MARK: - Lifecycle
    
    var body: some View {
        NavigationSplitView {
            VStack(spacing: .bigSpace) {
                List(selection: $selection) {
                    Section {
                        ForEach(MenuItem.menuItems, id: \.self) { item in
                            NavigationLink(value: item) {
                                Label(item.title, systemImage: item.symbol)
                            }
                        }
                    }
                    .listRowBackground(Color(uiColor: UIColor.secondarySystemBackground))
                }
                .background(Color(uiColor: UIColor.systemBackground))
                .scrollContentBackground(.hidden)

                Image(.logo)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.bigSpace)

                Spacer()
            }
            .background(Color(uiColor: UIColor.systemBackground))
        } detail: {
            if let selection = selection {
                NavigationStack {
                    switch selection.type {
                    case .trending:
                        TrendingView()
                    case .search:
                        SearchView()
                    case .favorite:
                        FavoriteView()
                    }
                }
                .navigationTitle(selection.title)
                .toolbarTitleDisplayMode(.large)
            } else {
                Text("Please select a menu item.")
                    .foregroundColor(Color(uiColor: .tertiaryLabel))
                    .padding(.contentSpace)
            }
        }
    }
}

#Preview {
    ContentView()
}
