//
//  FlickrAPIService.swift
//  FlickrApp
//
//  Created by Bhuvana Ravuri on 11/19/24.
//

import Foundation
import Combine

class FlickrAPIService {
    
    func fetchImages(for tags: String) -> AnyPublisher<[FlickrImage], Error> {
        let urlString = "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1&tags=\(tags)"
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: FlickrResponse.self, decoder: JSONDecoder())
            .map(\.items)
            .eraseToAnyPublisher()
    }
}
