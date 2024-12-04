//
//  ModelContext+Convenience.swift
//  MovieDatatbaseCompanion
//
//  Created by Paul Ehrhardt on 4/12/24.
//

import SwiftUI
import SwiftData


// MARK: - Extension: ModelContext -

extension ModelContext {

    func addFavorite(id: Int) {
        let newItem = Favorite(identifier: id)
        self.insert(newItem)
    }

    func deleteFavorite(id: Int) {
        let deleteItem = Favorite(identifier: id)
        self.delete(deleteItem)
    }

    func allFavorites() -> [Favorite] {
        let fetchDescriptor = FetchDescriptor<Favorite>()
        guard let favorites = try? self.fetch(fetchDescriptor) else { return [] }
        
        return favorites
    }
}
