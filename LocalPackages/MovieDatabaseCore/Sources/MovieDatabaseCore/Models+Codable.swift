//
//  Models+Codable.swift
//  MovieDatabaseCore
//
//  Created by Paul Ehrhardt on 29/11/24.
//

import Foundation


// MARK: - Error -

public enum Error: Swift.Error {
    case invalidURL, failedRequest
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
    public let backdropPath, posterPath: String?
    public let id: Int
    public let title, originalTitle, overview: String
    public let mediaType: MediaType?
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
    
    public init(backdropPath: String?, posterPath: String?, id: Int, title: String, originalTitle: String, overview: String, mediaType: MediaType?, adult: Bool, originalLanguage: String, genreIDS: [Int], popularity: Double, releaseDate: String, video: Bool, voteAverage: Double, voteCount: Int) {
        self.backdropPath = backdropPath
        self.posterPath = posterPath
        self.id = id
        self.title = title
        self.originalTitle = originalTitle
        self.overview = overview
        self.mediaType = mediaType
        self.adult = adult
        self.originalLanguage = originalLanguage
        self.genreIDS = genreIDS
        self.popularity = popularity
        self.releaseDate = releaseDate
        self.video = video
        self.voteAverage = voteAverage
        self.voteCount = voteCount
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
    
    public init(adult: Bool, backdropPath: String, budget: Int, genres: [Genre], homepage: String, id: Int, imdbID: String, originCountry: [String], originalLanguage: String, originalTitle: String, overview: String, popularity: Double, posterPath: String, releaseDate: String, revenue: Int, runtime: Int, status: String, tagline: String, title: String, video: Bool, voteAverage: Double, voteCount: Int) {
        self.adult = adult
        self.backdropPath = backdropPath
        self.budget = budget
        self.genres = genres
        self.homepage = homepage
        self.id = id
        self.imdbID = imdbID
        self.originCountry = originCountry
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.overview = overview
        self.popularity = popularity
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.revenue = revenue
        self.runtime = runtime
        self.status = status
        self.tagline = tagline
        self.title = title
        self.video = video
        self.voteAverage = voteAverage
        self.voteCount = voteCount
    }
}


// MARK: - MediaType -

public enum MediaType: String, Codable, Sendable {
    case movie, tv
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
    public let backdropPath, posterPath: String?
    public let id: Int
    public let name, originalName, overview: String
    public let mediaType: MediaType?
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
    
    public init(backdropPath: String?, posterPath: String?, id: Int, name: String, originalName: String, overview: String, mediaType: MediaType?, adult: Bool, originalLanguage: String, genreIDS: [Int], popularity: Double, firstAirDate: String, voteAverage: Double, voteCount: Int, originCountry: [String]) {
        self.backdropPath = backdropPath
        self.posterPath = posterPath
        self.id = id
        self.name = name
        self.originalName = originalName
        self.overview = overview
        self.mediaType = mediaType
        self.adult = adult
        self.originalLanguage = originalLanguage
        self.genreIDS = genreIDS
        self.popularity = popularity
        self.firstAirDate = firstAirDate
        self.voteAverage = voteAverage
        self.voteCount = voteCount
        self.originCountry = originCountry
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
    
    public init(adult: Bool, backdropPath: String, episodeRunTime: [Int], firstAirDate: String, genres: [Genre], homepage: String, id: Int, inProduction: Bool, languages: [String], lastAirDate: String, name: String, numberOfEpisodes: Int, numberOfSeasons: Int, originCountry: [String], originalLanguage: String, originalName: String, overview: String, popularity: Double, posterPath: String, seasons: [Season], status: String, tagline: String, type: String, voteAverage: Double, voteCount: Int) {
        self.adult = adult
        self.backdropPath = backdropPath
        self.episodeRunTime = episodeRunTime
        self.firstAirDate = firstAirDate
        self.genres = genres
        self.homepage = homepage
        self.id = id
        self.inProduction = inProduction
        self.languages = languages
        self.lastAirDate = lastAirDate
        self.name = name
        self.numberOfEpisodes = numberOfEpisodes
        self.numberOfSeasons = numberOfSeasons
        self.originCountry = originCountry
        self.originalLanguage = originalLanguage
        self.originalName = originalName
        self.overview = overview
        self.popularity = popularity
        self.posterPath = posterPath
        self.seasons = seasons
        self.status = status
        self.tagline = tagline
        self.type = type
        self.voteAverage = voteAverage
        self.voteCount = voteCount
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
    case w92, w154, w185, w342, w500, w780, original
}
