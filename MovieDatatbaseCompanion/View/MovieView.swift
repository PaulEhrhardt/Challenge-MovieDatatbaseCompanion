//
//  MovieView.swift
//  MovieDatatbaseCompanion
//
//  Created by Paul Ehrhardt on 30/11/24.
//

import SwiftUI
import MovieDatabaseCore


// MARK: - MovieView -

struct MovieView: View {
    
    
    // MARK: - Properties
    
    let movie: Movie
    let size: CGSize = CGSize(width: 300, height: 300)
    
    @State var image: UIImage?
    
    
    // MARK: - Lifecycle
    
    var body: some View {
        VStack {
            Image(uiImage: image ?? UIImage(resource: .placeholder))
                .resizable()
            Text(movie.title)
                .font(.title)
            Text(movie.overview)
                .font(.body)
        }
        .frame(minWidth: size.width, minHeight: size.height)
        .background(Color(UIColor.systemGray6))
        .task {
            // TODO: adaptive size
            if let backdropPath = movie.backdropPath, let data = try? await MovieDatabaseCore.shared.fetchImageData(size: .w154, path: backdropPath) {
                image = UIImage(data: data)
            }
        }
    }
}


// MARK: - Preview -

#Preview {
    MovieView(movie: PreviewModels.starWars)
}
