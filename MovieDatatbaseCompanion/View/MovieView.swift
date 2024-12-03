//
//  MovieView.swift
//  MovieDatatbaseCompanion
//
//  Created by Paul Ehrhardt on 30/11/24.
//

import SwiftUI
import UIKit.UIDevice
import MovieDatabaseCore


// MARK: - MovieView -

struct MovieView: View {
    
    
    // MARK: - Properties

    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    @State var image: UIImage?

    let movie: Movie
    
    
    // MARK: - Lifecycle
    
    var body: some View {
        NavigationLink {
            DetailsView(movieId: movie.id)
        } label: {
            VStack(spacing: .standardSpace) {
                Image(uiImage: image ?? UIImage(resource: .placeholder))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipped()
                Text(movie.title)
                    .font(.title)
                    .foregroundStyle(.primary)
                    .padding(.horizontal, .standardSpace)
                Text(movie.overview)
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, .standardSpace)
                    .padding(.bottom, .standardSpace)
            }
            .frame(maxWidth: 300, maxHeight: 400)
            .background(Color(UIColor.systemGray6))
            .overlay(
                RoundedRectangle(cornerRadius: .cornerSize)
                        .stroke(Color(uiColor: .systemGray2), lineWidth: 1)
                )
            .clipShape(RoundedRectangle(cornerRadius: .cornerSize))
            .task {
                guard let backdropPath = movie.backdropPath else { return }

                // load low-res preview image
                var imageSize = ImageSize.previewSize
                guard let previewData = try? await MovieDatabaseCore.shared.fetchImageData(size: imageSize, path: backdropPath) else { return }
                image = UIImage(data: previewData)

                // load hi-res image based on current size class
                imageSize = ImageSize.optimalSize(for: horizontalSizeClass ?? .compact)
                guard let imageData = try? await MovieDatabaseCore.shared.fetchImageData(size: imageSize, path: backdropPath) else { return }
                image = UIImage(data: imageData)
#if DEBUG
                print("Loaded image for '\(movie.title)' with size of: \(imageSize)")
#endif
            }
        }
    }
}


// MARK: - Preview -

#Preview {
    MovieView(movie: PreviewModels.starWars)
}
