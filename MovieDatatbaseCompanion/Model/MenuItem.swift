//
//  MenuItem.swift
//  MovieDatatbaseCompanion
//
//  Created by Paul Ehrhardt on 30/11/24.
//

import Foundation


// MARK: - MenuItem -

struct MenuItem: Hashable {
    
    enum `Type` {
        case trending, search, favorite
    }
    
    let title: String
    let symbol: String
    let type: `Type`
}

extension MenuItem {
    static let menuItems = [MenuItem(title: "Trending Movies", symbol: "popcorn", type: .trending),
                            MenuItem(title: "Search", symbol: "magnifyingglass", type: .search),
                            MenuItem(title: "Favorites", symbol: "star", type: .favorite)]
}
