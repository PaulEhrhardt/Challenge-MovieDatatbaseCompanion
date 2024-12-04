//
//  FavoriteView.swift
//  MovieDatatbaseCompanion
//
//  Created by Paul Ehrhardt on 4/12/24.
//

import SwiftUI
import SwiftData


// MARK: - FavoriteView -

struct FavoriteView: View {


    // MARK: - Properties

    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Favorite]


    // MARK: - Lifecycle

    var body: some View {
        Text("Hello, World!")
    }
}


// MARK: - Preview -

#Preview {
    FavoriteView()
        .modelContainer(for: Favorite.self, inMemory: true)
}
