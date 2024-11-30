//
//  MovieDatabaseCoreTests.swift
//  MovieDatabaseCore
//
//  Created by Paul Ehrhardt on 29/11/24.
//

import Testing
@testable import MovieDatabaseCore
import Foundation


struct MovieDatabaseCoreTests {
    
    // MARK: - Test Helper

    let apiKey: String = {
        let pathToProject = "/Documents/Workspace/ehd/MovieDatatbaseCompanion/"
        let secretFileName = "apikey.secret"
        let fullPath = NSHomeDirectory() + pathToProject + secretFileName
        let fileContent = try? String(contentsOfFile: fullPath, encoding: .utf8).trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            
        return fileContent ?? ""
    }()

    let mdc = MovieDatabaseCore.shared
    
    
    // MARK: - Tests: Setup Core client
    
    init() async {
        await mdc.registerApiKey(key: apiKey)
    }
    
    
    // MARK: - Tests: Core client
    
    @Test func core_versionString_retrievedCorrectly() async throws {
        #expect(mdc.version == "1.0.0")
    }
    
    @Test func apiKey_loadFromSecret_isSuccessful() async throws {
        #expect(apiKey.hasPrefix("ey"))
    }
    
    @Test func apiKey_register_isSuccessful() async throws {
        let databaseCore = MovieDatabaseCore()
        #expect(await databaseCore.hasApiKey == false)
        
        let dummyKey = "eyABCD1234"
        await databaseCore.registerApiKey(key: dummyKey)
        
        #expect(await databaseCore.hasApiKey == true)
    }
    
    
    // MARK: - Tests: Data Loading & Response Parsing
    //
    // Note:    In a production application you would not like to test through the
    //          HTTP layer like done here and instead try to mock the HTTPClient
    //          via protocol or inject a mocked URLSession using URLProtocol.
    
    @Test func fetch_trendingMovies_successfulResult() async throws {
        let movieResult = try await mdc.fetchTrendingMovies(page: 1)
        
        #expect(movieResult.page == 1)
        #expect(movieResult.results.isEmpty == false)
        #expect(movieResult.results.count == 20)
    }
    
    @Test func fetch_trendingMovies_throwsFailedRequestError() async throws {
        await #expect(throws: Error.failedRequest) {
            try await mdc.fetchTrendingMovies(page: 0)
        }
    }
    
    @Test func load_movieDetail_isSuccessfull() async throws {
        let movie = try await mdc.fetchMovieDetails(id: 11)
        
        #expect(movie.id == 11)
        #expect(movie.title == "Star Wars")
    }
    
    @Test func load_movieDetails_throwsFailedRequestError() async throws {
        await #expect(throws: Error.failedRequest) {
            try await mdc.fetchMovieDetails(id: -343)
        }
    }
    
    @Test func load_serieDetail_isSuccessfull() async throws {
        let movie = try await mdc.fetchSeriesDetails(id: 1668)
        
        #expect(movie.id == 1668)
        #expect(movie.name == "Friends")
    }
    
    @Test func load_fetchSerieDetails_throwsFailedRequestError() async throws {
        await #expect(throws: Error.failedRequest) {
            try await mdc.fetchSeriesDetails(id: -343)
        }
    }
    
    @Test func search_moviesByKeyword_successfulResult() async throws {
        let movieResult = try await mdc.searchForMovies(query: "Star Wars", page: 1)
        
        #expect(movieResult.page == 1)
        #expect(movieResult.results.isEmpty == false)
        #expect(movieResult.results.count == 20)
        #expect(movieResult.results.first?.title == "Star Wars")
    }
    
    @Test func search_moviesByKeyword_throwsFailedRequestError() async throws {
        await #expect(throws: Error.failedRequest) {
            try await mdc.searchForMovies(query: "", page: 0)
        }
    }
    
    @Test func search_seriesByKeyword_successfulResuls() async throws {
        let movieResult = try await mdc.searchForSeries(query: "Friends", page: 1)
        
        #expect(movieResult.page == 1)
        #expect(movieResult.results.isEmpty == false)
        #expect(movieResult.results.count == 20)
        #expect(movieResult.results.first?.name == "Friends")
    }
    
    @Test func search_seriesByKeyword_throwsFailedRequestError() async throws {
        await #expect(throws: Error.failedRequest) {
            try await mdc.searchForSeries(query: "", page: 0)
        }
    }
    
    @Test func fetch_imagesBySize_successfulReturnsImageDatas() async throws {
        let smallestImageData = try await mdc.fetchImageData(size: .w92, path: "/l0qVZIpXtIo7km9u5Yqh0nKPOr5.jpg")
        let mediumImageData = try await mdc.fetchImageData(size: .w500, path: "/l0qVZIpXtIo7km9u5Yqh0nKPOr5.jpg")
        let biggestImageData = try await mdc.fetchImageData(size: .original, path: "/l0qVZIpXtIo7km9u5Yqh0nKPOr5.jpg")
        
        #expect(!smallestImageData.isEmpty && !mediumImageData.isEmpty && !biggestImageData.isEmpty)
        #expect(smallestImageData.count < mediumImageData.count)
        #expect(mediumImageData.count < biggestImageData.count)
    }
    
    @Test func fetch_imagesBySize_throwsFailedRequestError() async throws {
        await #expect(throws: Error.failedRequest) {
            try await mdc.fetchImageData(size: .w92, path: "/l0qVZIpXtIo7km9u5Yqh0nKPOr5")
        }
    }
}
