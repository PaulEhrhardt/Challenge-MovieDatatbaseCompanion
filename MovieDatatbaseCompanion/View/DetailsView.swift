//
//  DetailsView.swift
//  MovieDatatbaseCompanion
//
//  Created by Paul Ehrhardt on 1/12/24.
//

import SwiftUI
import UIKit
import MovieDatabaseCore


// MARK: - DetailsView

struct DetailsView: UIViewControllerRepresentable {


    // MARK: - Types

    typealias UIViewControllerType = DetailsViewController


    // MARK: - Properties

    let movieId: Int
    @State var movie: MovieDetail?


    // MARK: - Lifecycle

    func makeUIViewController(context: Context) -> DetailsViewController {
        let storyboard = UIStoryboard(name: "DetailsStoryboard", bundle: .main)
        let viewController: DetailsViewController = storyboard.instantiateViewController(identifier: "DetailsViewController")

        loadDetails()

        return viewController
    }

    func updateUIViewController(_ uiViewController: DetailsViewController, context: Context) {
        uiViewController.scrollViewVisibility(shouldShow: movie != nil)
        uiViewController.scrollViewVisibility(shouldShow: true)
        uiViewController.imageView.image = UIImage(resource: .placeholder) // TODO: load
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
        }
    }
}


// MARK: - Preview -

#Preview {
    DetailsView(movieId: 99)
        .padding()
}
