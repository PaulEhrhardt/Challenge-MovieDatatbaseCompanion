//
//  ApiKey.swift
//  MovieDatatbaseCompanion
//
//  Created by Paul Ehrhardt on 29/11/24.
//

import Foundation

let apiKey: String = {
 //   let pathToProject = "/Users/ehd/Documents/Workspace/ehd/MovieDatatbaseCompanion"
    let pathToProject = "/Users/ehrpaulhardt/Documents/Workspace/ehd/MovieDatatbaseCompanion"
    let secretFileName = "/apikey.secret"
    let fullPath = pathToProject + secretFileName
    let fileContent = try? String(contentsOfFile: fullPath, encoding: .utf8).trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    
    return fileContent ?? ""
}()
