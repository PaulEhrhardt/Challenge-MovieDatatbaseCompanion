//
//  File.swift
//  MovieDatabaseCore
//
//  Created by Paul Ehrhardt on 29/11/24.
//

import Foundation


// MARK: - HttpService -

internal actor HttpClient {
    
    
    // MARK: - Types
    
    // https://developer.themoviedb.org/reference/configuration-details
    enum Config {
        static let imageBaseUrl = "https://image.tmdb.org/t/p"
        static let baseUrl = "https://api.themoviedb.org"
        static let version = "/3"
        static let trendingMovies = "/trending/movie/day"
        static let movieDetails = "/movie"
        static let serieDetails = "/tv"
        static let searchMovie = "/search/movie"
        static let searchSerie = "/search/tv"
    }
    
    
    // MARK: - Properties
    
    private var urlSession: URLSession
    private var apiKey: String
    
    var hasApiKey: Bool {
        get async { !apiKey.isEmpty }
    }
    
    
    // MARK: - Initialization
    
    init(urlSession: URLSession = URLSession.shared, apiKey: String = "") {
        self.urlSession = urlSession
        self.apiKey = apiKey
    }
    
    
    // MARK: - API
    
    func registerApiKey(key: String) {
        apiKey = key
    }
    
    func fetchTrendingMovies(page: Int, language: String) async throws -> MovieResult {
        guard let url = URL(string: Config.baseUrl + Config.version + Config.trendingMovies) else { throw Error.invalidURL }
        
        let queryItems: [URLQueryItem] = [URLQueryItem(name: "language", value: language),
                                          URLQueryItem(name: "page", value: String(page))]
        let data = try await request(url: url, queryItems: queryItems)
        
        return try JSONDecoder().decode(MovieResult.self, from: data)
    }
    
    func fetchDetails<T: Codable>(returnType: T.Type, id: Int, language: String) async throws -> T {
        let details = returnType == MovieDetail.self ? Config.movieDetails : Config.serieDetails
        guard let url = URL(string: Config.baseUrl + Config.version + details + "/\(String(id))") else { throw Error.invalidURL }
 
        let queryItems = [URLQueryItem(name: "language", value: language)]
        let data = try await request(url: url, queryItems: queryItems)
        
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    func searchFilms<T: Codable>(returnType: T.Type, query: String, page: Int, language: String) async throws -> T {
        let details = returnType == MovieResult.self ? Config.searchMovie : Config.searchSerie
        guard let url = URL(string: Config.baseUrl + Config.version + details) else { throw Error.invalidURL }
        
        let queryItems: [URLQueryItem] = [URLQueryItem(name: "query", value: query),
                                          URLQueryItem(name: "language", value: language),
                                          URLQueryItem(name: "page", value: String(page))]
        let data = try await request(url: url, queryItems: queryItems)
        
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    func fetchImageData(size: ImageSize, path: String, language: String) async throws -> Data {
        guard let url = URL(string: Config.imageBaseUrl + "/\(size.rawValue)" + "/\(path)") else { throw Error.invalidURL }
        
        let request = createGetRequest(from: url)
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let response = response as? HTTPURLResponse, 200...300 ~= response.statusCode else { throw Error.failedRequest }
        
        return data
    }
    
    
    // MARK: - Internal
    
    private func request(url: URL, queryItems: [URLQueryItem]) async throws -> Data {
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else { throw Error.invalidURL }
        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems
        guard let url = components.url else { throw Error.invalidURL }
        let request = createGetRequest(from: url)
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let response = response as? HTTPURLResponse, 200...300 ~= response.statusCode else { throw Error.failedRequest }
        
        return data
    }
    
    private func createGetRequest(from url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
          "accept": "application/json",
          "Authorization": "Bearer \(apiKey)"
        ]
        
        return request
    }
}
