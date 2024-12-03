//
//  ImageSize+Resolutions.swift
//  MovieDatatbaseCompanion
//
//  Created by Paul Ehrhardt on 3/12/24.
//

import MovieDatabaseCore
import SwiftUI


extension ImageSize {

    static var previewSize: ImageSize {
        .w154
    }

    static func optimalSize(for sizeClass: UserInterfaceSizeClass) -> ImageSize {
        let size: ImageSize = sizeClass == .compact ? .w500 : .original
        return size
    }
}
