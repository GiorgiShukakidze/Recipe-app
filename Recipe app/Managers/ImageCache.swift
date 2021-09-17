//
//  ImageCache.swift
//  Recipe app
//
//  Created by Giorgi Shukakidze on 16.09.21.
//

import Foundation
import SwiftUI

class ImageCache {
    static let shared = ImageCache()

    private let imageCache = NSCache<NSString, UIImage>()
    private lazy var lock = NSLock()

    func cachedImage(for url: String) -> UIImage? {
        lock.lock(); defer { lock.unlock() }

        if let cachedImage = imageCache.object(forKey: url as NSString) {
            return cachedImage
        }
        
        return nil
    }
    
    func cacheImage(_ image: UIImage?, for key: String) {
        lock.lock(); defer { lock.unlock() }

        if let image = image {
            imageCache.setObject(image, forKey: key as NSString)
        }
    }
}
