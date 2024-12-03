//
//  ImageSize+Resolutions.swift
//  MovieDatatbaseCompanion
//
//  Created by Paul Ehrhardt on 3/12/24.
//

import MovieDatabaseCore
import SwiftUI


// MARK: - Image loading helpers -

extension ImageSize {
    static var previewSize: ImageSize {
        .w154
    }
}


extension View {
    func previewImage(for path: String?) async -> UIImage? {
        guard let path = path else { return nil }
        let imageSize = ImageSize.previewSize
        guard let previewData = try? await MovieDatabaseCore.shared.fetchImageData(size: imageSize, path: path) else { return nil }
        return UIImage(data: previewData)
    }

    func optimalImage(for path: String?, sizeClass: UserInterfaceSizeClass) async -> UIImage? {
        guard let path = path else { return nil }
        let imageSize = optimalSize(for: sizeClass)
        guard let imageData = try? await MovieDatabaseCore.shared.fetchImageData(size: imageSize, path: path) else { return nil }
        return UIImage(data: imageData)
    }

    private func optimalSize(for sizeClass: UserInterfaceSizeClass) -> ImageSize {
        let size: ImageSize = sizeClass == .compact ? .w500 : .original
        return size
    }
}
