//
//  FlickrViewModel.swift
//  FlickrApp
//
//  Created by Bhuvana Ravuri on 11/19/24.
//

import Foundation
import SwiftUI
import Combine

class FlickrViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var images: [FlickrImage] = []
    @Published var isLoading = false
    @Published var isShowingDetailView = false
    var flickrImage: FlickrImage? {
        didSet {
            isShowingDetailView = true
        }
    }
    
    private var cancellables = Set<AnyCancellable>()
    private let service = FlickrAPIService()
    
    init() {
        $searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] query in
                self?.fetchImages(for: query)
            }
            .store(in: &cancellables)
    }
    
    func fetchImages(for tags: String) {
        guard !tags.isEmpty else { return }
        isLoading = true
        service.fetchImages(for: tags)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case .failure = completion {
                    self?.images = []
                }
            }, receiveValue: { [weak self] items in
                self?.images = items
            })
            .store(in: &cancellables)
    }
}
