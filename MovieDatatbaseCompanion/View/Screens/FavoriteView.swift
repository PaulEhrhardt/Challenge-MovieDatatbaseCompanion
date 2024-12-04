//
//  FavoriteView.swift
//  MovieDatatbaseCompanion
//
//  Created by Paul Ehrhardt on 4/12/24.
//

import SwiftUI
import SwiftData
import PINCache


// MARK: - FavoriteView -

struct FavoriteView: View {


    // MARK: - Properties

    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.modelContext) var modelContext
    @Query var favorites: [Favorite]


    // MARK: - Properties

    @State var image: UIImage?

    let cache = PINCache.shared
    let columns = [GridItem(.adaptive(minimum: 300))]


    // MARK: - Lifecycle

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: .bigSpace) {
                ForEach(favorites, id: \.self) { favorite in
                    FilmView(item: favorite.asFilmItem())
                }
                if favorites.isEmpty {
                    Text("Favorites list is empty. Try to add Movies!")
                        .foregroundColor(Color(uiColor: .tertiaryLabel))
                        .padding(.contentSpace)
                }
            }
            .padding(.top, .bigSpace)
        }
    }
}


// MARK: - Preview -

#Preview {
    FavoriteView()
        .modelContainer(for: Favorite.self, inMemory: true)
}
