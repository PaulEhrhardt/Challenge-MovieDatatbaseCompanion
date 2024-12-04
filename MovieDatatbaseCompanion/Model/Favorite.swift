//
//  Favorite.swift
//  MovieDatatbaseCompanion
//
//  Created by Paul Ehrhardt on 29/11/24.
//

import Foundation
import SwiftData


// MARK: - SwiftData Models -

@Model
final class Favorite {
    @Attribute(.unique) var identifier: Int
    var imagePath: String?
    var title: String
    var overview: String

    init(identifier: Int, imagePath: String?, title: String, overview: String) {
        self.identifier = identifier
        self.imagePath = imagePath
        self.title = title
        self.overview = overview
    }
}
