//
//  MenuItem.swift
//  MovieDatatbaseCompanion
//
//  Created by Paul Ehrhardt on 30/11/24.
//

import Foundation

struct MenuItem: Hashable {
    
    enum `Type` {
        case trending, search
    }
    
    let title: String
    let symbol: String
    let type: `Type`
}

extension MenuItem {
    static let menuItems = [MenuItem(title: "Trending Movies", symbol: "popcorn", type: .trending),
                            MenuItem(title: "Search", symbol: "magnifyingglass", type: .search)]
}
