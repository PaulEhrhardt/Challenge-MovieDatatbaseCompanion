//
//  FilmView.swift
//  MovieDatatbaseCompanion
//
//  Created by Paul Ehrhardt on 30/11/24.
//

import SwiftUI
import UIKit.UIDevice
import PINCache


// MARK: - FilmView -

struct FilmView: View {

    
    // MARK: - Properties

    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    @State var image: UIImage?

    let item: FilmItem
    let cache = PINCache.shared

    
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
                guard let path = item.imagePath else { return }

                if await cache.hasEntry(for: path) {
                    cache.object(forKeyAsync: path) { _, _, obj in
                        image = obj as? UIImage
                    }
                } else {
                    // load low-res preview image
                    image = await previewImage(for: path)

                    // load hi-res image based on current size class
                    image = await optimalImage(for: path, sizeClass: horizontalSizeClass ?? .compact)

                    // add the image to cache
                    await cache.add(image: image, for: path)
                }
            }
        }
    }
}


// MARK: - Preview -

#Preview {
    FilmView(item: PreviewModels.starWars.asFilmItem())
}
