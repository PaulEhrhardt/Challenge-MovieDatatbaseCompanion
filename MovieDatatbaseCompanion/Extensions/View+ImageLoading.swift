//
//  View+ImageLoading.swift
//  MovieDatatbaseCompanion
//
//  Created by Paul Ehrhardt on 3/12/24.
//

import MovieDatabaseCore
import SwiftUI


// MARK: - Extension: ImageSize -

extension ImageSize {

    static var previewSize: ImageSize {
        .w154
    }
}


// MARK: - Extension: View -

extension View {

    func previewImage(for path: String) async -> UIImage? {
        let imageSize = ImageSize.previewSize
        guard let previewData = try? await MovieDatabaseCore.shared.fetchImageData(size: imageSize, path: path) else { return nil }
        return UIImage(data: previewData)
    }

    func optimalImage(for path: String, sizeClass: UserInterfaceSizeClass) async -> UIImage? {
        let imageSize = optimalSize(for: sizeClass)
        guard let imageData = try? await MovieDatabaseCore.shared.fetchImageData(size: imageSize, path: path) else { return nil }
        return UIImage(data: imageData)
    }

    private func optimalSize(for sizeClass: UserInterfaceSizeClass) -> ImageSize {
        let size: ImageSize = sizeClass == .compact ? .w500 : .original
        return size
    }
}
