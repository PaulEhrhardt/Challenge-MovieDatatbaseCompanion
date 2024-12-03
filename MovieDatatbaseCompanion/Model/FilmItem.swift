//
//  FilmItem.swift
//  MovieDatatbaseCompanion
//
//  Created by Paul Ehrhardt on 3/12/24.
//

import SwiftUI
import MovieDatabaseCore


// MARK: - FilmItem -

struct FilmItem {
    let id: Int
    let imagePath: String?
    let title: String
    let overview: String
    let isSeries: Bool
}


// MARK: - Extensions -

extension Movie {

    func asFilmItem() -> FilmItem {
        FilmItem(id: id, imagePath: backdropPath, title: title, overview: overview, isSeries: false)
    }
}

extension Serie {

    func asFilmItem() -> FilmItem {
        FilmItem(id: id, imagePath: backdropPath, title: name, overview: overview, isSeries: true)
    }
}
