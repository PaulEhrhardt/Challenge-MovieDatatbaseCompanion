//
//  DetailsView.swift
//  MovieDatatbaseCompanion
//
//  Created by Paul Ehrhardt on 1/12/24.
//

import SwiftUI
import UIKit
import MovieDatabaseCore
import PINCache


// MARK: - DetailsView -

struct DetailsView: View {

    let item: FilmItem

    var body: some View {
        if item.isSeries {
            Text("Sorry, details are currently only available for movies.")
        } else {
            DetailsViewRepresentable(movieId: item.id)
                .background(Color(UIColor.systemGray6).ignoresSafeArea(.all))
                .clipShape(RoundedRectangle(cornerRadius: .cornerSize))
                .padding(.horizontal, .itemSpace)
        }
    }
}


// MARK: - DetailsViewRepresentable -

struct DetailsViewRepresentable: UIViewControllerRepresentable {


    // MARK: - Types

    typealias UIViewControllerType = DetailsViewController


    // MARK: - Properties

    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    let movieId: Int
    @State var movie: MovieDetail?
    @State var image: UIImage?


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
            movie = try await MovieDatabaseCore.shared.fetchMovieDetails(id: movieId)
            guard let path = movie?.backdropPath else { return }
            if await hasCacheEntry(for: path) {
                PINCache.shared.object(forKeyAsync: path) { _, _, obj in
                    image = obj as? UIImage
                }
            } else {
                image = await previewImage(for: path)
                image = await optimalImage(for: path, sizeClass: horizontalSizeClass ?? .compact)
                await addToCache(image: image, for: path)
            }
        }
    }
}


// MARK: - Preview -

#Preview {
    DetailsView(item: PreviewModels.starWars.asFilmItem())
}
