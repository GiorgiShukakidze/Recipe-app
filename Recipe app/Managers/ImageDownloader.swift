//
//  ImageDownloader.swift
//  Recipe app
//
//  Created by Giorgi Shukakidze on 16.09.21.
//

import Foundation
import SwiftUI
import Combine

protocol ImageDownloaderType {
    func imagePublisher(for urlStrings: [String]) -> AnyPublisher<UIImage?, Never>
    func imagePublisher(for urlString: String) -> AnyPublisher<UIImage?, Never>
}

class ImageDownloader: ImageDownloaderType {
    private lazy var cancellables = Set<AnyCancellable>()
    private let cache = ImageCache.shared
    
    func imagePublisher(for urlStrings: [String]) -> AnyPublisher<UIImage?, Never> {
        Publishers.MergeMany(urlStrings.map { loadImage(for: $0) }).eraseToAnyPublisher()
    }
    
    func imagePublisher(for urlString: String) -> AnyPublisher<UIImage?, Never> {
        loadImage(for: urlString).eraseToAnyPublisher()
    }
    
    private func loadImage(for urlString: String) -> AnyPublisher<UIImage?, Never> {
        if let cached = cache.cachedImage(for: urlString) {
            return Just(cached).eraseToAnyPublisher()
        } else {
            return dataToImagePublisher(urlString)
        }
    }
    
    private func dataToImagePublisher(_ urlString: String) -> AnyPublisher<UIImage?, Never> {
        guard let url = URL(string: urlString) else { return Empty().eraseToAnyPublisher() }
                
        return URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: RunLoop.main)
            .map(\.data)
            .map({UIImage(data: $0)})
            .handleEvents(receiveOutput: {[weak self] image in
                self?.cache.cacheImage(image, for: urlString)
            })
            .replaceError(with: nil)
            .eraseToAnyPublisher()
    }
}
