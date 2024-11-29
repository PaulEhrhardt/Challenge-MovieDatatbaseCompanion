//
//  File.swift
//  MovieDatabaseCore
//
//  Created by Paul Ehrhardt on 29/11/24.
//

import Foundation


// MARK: - HttpService -

actor HttpClient {
    
    
    // MARK: - Types
    
    // https://developer.themoviedb.org/reference/configuration-details
    enum Config {
        static let imageBaseUrl = "https://image.tmdb.org/t/p"
        static let baseUrl = "https://api.themoviedb.org"
        static let version = "/3"
        static let trendingMovies = "/trending/movie/day"
    }

    
    // MARK: - Properties
    
    private var apiKey: String = ""
    
    var hasApiKey: Bool {
        get async { !apiKey.isEmpty }
    }
    
    
    // MARK: - API
    
    func registerApiKey(key: String) {
        apiKey = key
    }
    
    func fetchTrendingMovies(page: Int, language: String = "en-US") async throws -> MovieResult {
        guard page > 0 else { throw Error.invalidParam }
        guard let initialUrl = URL(string: Config.baseUrl + Config.version + Config.trendingMovies) else {
            throw Error.invalidURL
        }
        guard var components = URLComponents(url: initialUrl, resolvingAgainstBaseURL: true) else { throw Error.invalidURL }
        let queryItems: [URLQueryItem] = [
          URLQueryItem(name: "language", value: language),
          URLQueryItem(name: "page", value: String(page)),
        ]
        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems
        guard let url = components.url else { throw Error.invalidURL }
        let request = createGetRequest(from: url)
        
        if #available(macOS 12.0, *) {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let response = response as? HTTPURLResponse, 200...300 ~= response.statusCode else { throw Error.badRequest }
            //print(String(decoding: data, as: UTF8.self))
            return try JSONDecoder().decode(MovieResult.self, from: data)
        } else {
            // Fallback to earlier versions for a ready-to-market application
            throw Error.apiNotSupported
        }
    }
    
    
    // MARK: - Internal
    
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
