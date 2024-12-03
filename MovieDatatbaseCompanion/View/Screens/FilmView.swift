//
//  FilmView.swift
//  MovieDatatbaseCompanion
//
//  Created by Paul Ehrhardt on 30/11/24.
//

import SwiftUI
import UIKit.UIDevice
import MovieDatabaseCore


// MARK: - FilmView -

struct FilmView: View {

    
    // MARK: - Properties

    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    @State var image: UIImage?

    let item: FilmItem

    
    // MARK: - Lifecycle
    
    var body: some View {
        NavigationLink {
            DetailsView(item: item)
        } label: {
            VStack(spacing: .standardSpace) {
                Image(uiImage: image ?? UIImage(resource: .placeholder))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipped()
                Text(item.title)
                    .font(.title)
                    .foregroundStyle(Color(UIColor.label))
                    .padding(.horizontal, .standardSpace)
                Text(item.overview)
                    .font(.body)
                    .foregroundStyle(Color(UIColor.secondaryLabel))
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
                // load low-res preview image
                image = await previewImage(for: item.imagePath)

                // load hi-res image based on current size class
                image = await optimalImage(for: item.imagePath, sizeClass: horizontalSizeClass ?? .compact)
            }
        }
    }
}


// MARK: - Preview -

#Preview {
    FilmView(item: PreviewModels.starWars.asFilmItem())
}
