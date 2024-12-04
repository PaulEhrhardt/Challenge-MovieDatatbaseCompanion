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

    @MainActor
    func addFavorite(item: FilmItem) {
        let newItem = Favorite(identifier: item.id, imagePath: item.imagePath, title: item.title, overview: item.overview)
        self.insert(newItem)
        try? self.save()
    }

    @MainActor
    func deleteFavorite(item: FilmItem) {
        for favorite in allFavorites() where favorite.identifier == item.id {
            self.delete(favorite)
            try? self.save()
            break
        }
    }

    @MainActor
    func allFavorites() -> [Favorite] {
        let fetchDescriptor = FetchDescriptor<Favorite>()
        guard let favorites = try? self.fetch(fetchDescriptor) else { return [] }
        
        return favorites
    }
}
