//
//  DetailsView.swift
//  MovieDatatbaseCompanion
//
//  Created by Paul Ehrhardt on 1/12/24.
//

import SwiftUI
import SwiftData
import UIKit
import MovieDatabaseCore
import PINCache


// MARK: - DetailsView -

struct DetailsView: View {


    // MARK: - Properties

    @Environment(\.modelContext) private var modelContext
    @State var isFavorite = false {
        didSet {
            isFavorite ? modelContext.addFavorite(id: item.id) : modelContext.deleteFavorite(id: item.id)
        }
    }

    let item: FilmItem


    // MARK: - Lifecycle

    var body: some View {
        if item.isSeries {
            Text("Sorry, details are currently only available for movies.")
        } else {
            DetailsViewRepresentable(movieId: item.id)
                .background(Color(UIColor.systemGray6).ignoresSafeArea(.all))
                .clipShape(RoundedRectangle(cornerRadius: .cornerSize))
                .padding(.horizontal, .itemSpace)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            isFavorite.toggle()
                        } label: {
                            Image(systemName: isFavorite ? "star.fill" : "star")
                                .resizable()
                                .scaledToFit()
                                .tint(.brandPrimary)
                        }
                    }
                }
                .onAppear {
                    markFavoriteIfNeeded()
                }
        }
    }

    private func markFavoriteIfNeeded() {
        print("found favorites: \(modelContext.allFavorites().count)")
        for favorite in modelContext.allFavorites() where favorite.identifier == item.id {
            isFavorite = true
        }
    }
}


// MARK: - DetailsViewRepresentable -

struct DetailsViewRepresentable: UIViewControllerRepresentable {


    // MARK: - Types

    typealias UIViewControllerType = DetailsViewController


    // MARK: - Properties

    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    @State var movie: MovieDetail?
    @State var image: UIImage?

    let movieId: Int
    let cache = PINCache.shared
    let coreClient = MovieDatabaseCore.shared


    // MARK: - Lifecycle

    func makeUIViewController(context: Context) -> DetailsViewController {
        let storyboard = UIStoryboard(name: "DetailsStoryboard", bundle: .main)
        let viewController: DetailsViewController = storyboard.instantiateViewController(identifier: "DetailsViewController")

        loadDetails()

        return viewController
    }

    func updateUIViewController(_ uiViewController: DetailsViewController, context: Context) {
        uiViewController.scrollViewVisibility(shouldShow: movie != nil)

        uiViewController.imageView.image = image ?? UIImage(resource: .placeholder)
        uiViewController.titleLabel.text = movie?.title ?? ""
        uiViewController.overviewLabel.text = movie?.overview ?? ""
        uiViewController.originTitleLabel.text = movie?.originalTitle ?? ""
        uiViewController.releaseDateLabel.text = movie?.releaseDate ?? ""
        uiViewController.originCountryLabel.text = movie?.originCountry.first ?? ""
        uiViewController.homepageLabel.text = movie?.homepage ?? ""
        uiViewController.averageVoteLabel.text = String(movie?.voteAverage ?? 0)
    }


    // MARK: - Internal

    private func loadDetails() {
        // For simplicity we do not react on errors here
        Task {
            movie = try await coreClient.fetchMovieDetails(id: movieId)
            guard let path = movie?.backdropPath else { return }
            if await cache.hasEntry(for: path) {
                cache.object(forKeyAsync: path) { _, _, obj in
                    image = obj as? UIImage
                }
            } else {
                image = await previewImage(for: path)
                image = await optimalImage(for: path, sizeClass: horizontalSizeClass ?? .compact)
                await cache.add(image: image, for: path)
            }
        }
    }
}


// MARK: - Preview -

#Preview {
    DetailsView(item: PreviewModels.starWars.asFilmItem())
        .modelContainer(for: Favorite.self, inMemory: true)
}
