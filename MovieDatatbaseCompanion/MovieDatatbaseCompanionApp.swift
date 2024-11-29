//
//  MovieDatatbaseCompanionApp.swift
//  MovieDatatbaseCompanion
//
//  Created by Paul Ehrhardt on 29/11/24.
//

import SwiftUI
import SwiftData
import MovieDatabaseCore

@main
struct MovieDatatbaseCompanionApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .task {
                    // register API key before use
                    await MovieDatabaseCore.shared.registerApiKey(key: apiKey)
                }
        }
        .modelContainer(sharedModelContainer)
    }
}
