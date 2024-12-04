//
//  PINCache+Convenience.swift
//  MovieDatatbaseCompanion
//
//  Created by Paul Ehrhardt on 4/12/24.
//

import PINCache
import UIKit


// MARK: - Extension: PINCache -

extension PINCache {

    func add(image: UIImage?, for path: String) async {
        guard let image = image else { return }
        await self.setObjectAsync(image, forKey: path)
    }

    func hasEntry(for path: String) async -> Bool {
        await self.containsObject(forKeyAsync: path)
    }
}
