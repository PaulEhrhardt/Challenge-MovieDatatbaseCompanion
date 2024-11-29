import Testing
import MovieDatabaseCore
import Foundation


// MARK: - Test Helper -

let apiKey: String = {
    let pathToProject = "/Documents/Workspace/ehd/MovieDatatbaseCompanion/"
    let secretFileName = "apikey.secret"
    let fullPath = NSHomeDirectory() + pathToProject + secretFileName
    let fileContent = try? String(contentsOfFile: fullPath).trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
    
    return fileContent ?? ""
}()

let mdc = MovieDatabaseCore.shared


// MARK: - Tests -

@Test func core_versionString_retrievedCorrectly() async throws {
    #expect(mdc.version == "1.0.0")
}

@Test func apiKey_loadFromSecret_isSuccessful() async throws {
    #expect(apiKey.hasPrefix("ey"))
}

@Test func apiKey_register_isSuccessful() async throws {
    #expect(await mdc.hasApiKey == false)
    
    let dummyKey = "eyABCD1234"
    await mdc.registerApiKey(key: dummyKey)
    
    #expect(await mdc.hasApiKey == true)
}

@Test func load_trendingMovies_isSuccessfull() async throws {
    await mdc.registerApiKey(key: apiKey)
    let movieResult = try await mdc.fetchTrendingMovies(page: 1)
    
    #expect(movieResult.page == 1)
    #expect(movieResult.results.isEmpty == false)
    #expect(movieResult.results.count == 20)
}

@Test func load_trendingMovies_throwsErrorInvalidParam() async throws {
    await #expect(throws: Error.invalidParam, performing: {
        try await mdc.fetchTrendingMovies(page: 0)
    })
}
