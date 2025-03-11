//
//  ApiKey.swift
//  MovieDatatbaseCompanion
//
//  Created by Paul Ehrhardt on 29/11/24.
//

import Foundation


// MARK: - Globals -

let apiKey: String = {
    /*
     Note: This method only works in development/debug environment where Xcode runs the app from the derived data folder.
     If the app is running on a real device, the workspace directory won't be accessible due to sandboxing.
     For production consider using Environment Variables, embedding the secret file inside the app bundle or fetching secrets securely via Keychain or an API.
     */
    let secretFileName = "apikey.secret"
    
    // get file path of the current file
    let currentFilePath = URL(fileURLWithPath: #file)

    // move up to the project directory and then the workspace root
    let filePath = currentFilePath
        .deletingLastPathComponent() // move out of the current Swift file's folder and some levels up to secrets file
        .deletingLastPathComponent()
        .deletingLastPathComponent()
        .appendingPathComponent(secretFileName).path

    var fileContent: String?
    do {
        fileContent = try String(contentsOfFile: filePath, encoding: .utf8)
            .trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    } catch {
        print("Failed to read .secret file: \(error)")
    }
    
    return fileContent ?? ""
}()
