//
//  Models+Codable.swift
//  MovieDatabaseCore
//
//  Created by Paul Ehrhardt on 29/11/24.
//

import Foundation


// MARK: - Error -

public enum Error: Swift.Error {
    case invalidParam, invalidURL, apiNotSupported, dataParsing, badRequest
}


// MARK: - MovieResult -

public struct MovieResult: Codable, Sendable {
    public let page: Int
    public let results: [Movie]
    public let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}


// MARK: - Movie -

public struct Movie: Codable, Sendable, Hashable, Identifiable {
    public let backdropPath: String?
    public let id: Int
    public let title, originalTitle, overview, posterPath: String
    public let mediaType: MediaType
    public let adult: Bool
    public let originalLanguage: String
    public let genreIDS: [Int]
    public let popularity: Double
    public let releaseDate: String
    public let video: Bool
    public let voteAverage: Double
    public let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case id, title
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case adult
        case originalLanguage = "original_language"
        case genreIDS = "genre_ids"
        case popularity
        case releaseDate = "release_date"
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}


// MARK: - MovieDetail -

public struct MovieDetail: Codable, Sendable {
    public let adult: Bool
    public let backdropPath: String
    public let budget: Int
    public let genres: [Genre]
    public let homepage: String
    public let id: Int
    public let imdbID: String
    public let originCountry: [String]
    public let originalLanguage, originalTitle, overview: String
    public let popularity: Double
    public let posterPath: String
    public let releaseDate: String
    public let revenue, runtime: Int
    public let status, tagline, title: String
    public let video: Bool
    public let voteAverage: Double
    public let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case budget, genres, homepage, id
        case imdbID = "imdb_id"
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case revenue, runtime
        case status, tagline, title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}


// MARK: - MediaType -

public enum MediaType: String, Codable, Sendable {
    case movie = "movie"
    case tv = "tv"
}


// MARK: - Genre -

public struct Genre: Codable, Sendable {
    public let id: Int
    public let name: String
}


// MARK: - SerieResult -

public struct SerieResult: Codable, Sendable {
    public let page: Int
    public let results: [Serie]
    public let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}


// MARK: - Serie -

public struct Serie: Codable, Sendable, Hashable, Identifiable {
    public let backdropPath: String?
    public let id: Int
    public let name, originalName, overview, posterPath: String
    public let mediaType: MediaType
    public let adult: Bool
    public let originalLanguage: String
    public let genreIDS: [Int]
    public let popularity: Double
    public let firstAirDate: String
    public let voteAverage: Double
    public let voteCount: Int
    public let originCountry: [String]

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case id, name
        case originalName = "original_name"
        case overview
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case adult
        case originalLanguage = "original_language"
        case genreIDS = "genre_ids"
        case popularity
        case firstAirDate = "first_air_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case originCountry = "origin_country"
    }
}


// MARK: - SerieDetail -

public struct SerieDetail: Codable, Sendable {
    public let adult: Bool
    public let backdropPath: String
    public let episodeRunTime: [Int]
    public let firstAirDate: String
    public let genres: [Genre]
    public let homepage: String
    public let id: Int
    public let inProduction: Bool
    public let languages: [String]
    public let lastAirDate: String
    public let name: String
    public let numberOfEpisodes, numberOfSeasons: Int
    public let originCountry: [String]
    public let originalLanguage, originalName, overview: String
    public let popularity: Double
    public let posterPath: String
    public let seasons: [Season]
    public let status, tagline, type: String
    public let voteAverage: Double
    public let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case episodeRunTime = "episode_run_time"
        case firstAirDate = "first_air_date"
        case genres, homepage, id
        case inProduction = "in_production"
        case languages
        case lastAirDate = "last_air_date"
        case name
        case numberOfEpisodes = "number_of_episodes"
        case numberOfSeasons = "number_of_seasons"
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview, popularity
        case posterPath = "poster_path"
        case seasons
        case status, tagline, type
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}


// MARK: - Season -

public struct Season: Codable, Sendable {
    public let airDate: String
    public let episodeCount, id: Int
    public let name, overview, posterPath: String
    public let seasonNumber: Int
    public let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case airDate = "air_date"
        case episodeCount = "episode_count"
        case id, name, overview
        case posterPath = "poster_path"
        case seasonNumber = "season_number"
        case voteAverage = "vote_average"
    }
}


// MARK: - ImageSize -

public enum ImageSize: String, Sendable {
    case w92 = "w92"
    case w154 = "w154"
    case w185 = "w185"
    case w342 = "w342"
    case w500 = "w500"
    case w780 = "w780"
    case original = "original"
}
