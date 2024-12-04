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
    var identifier: Int

    init(identifier: Int) {
        self.identifier = identifier
    }
}
