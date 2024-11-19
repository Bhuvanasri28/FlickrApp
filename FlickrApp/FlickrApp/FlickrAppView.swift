//
//  FlickrAppView.swift
//  FlickrApp
//
//  Created by Bhuvana Ravuri on 11/19/24.
//

import SwiftUI

struct FlickrAppView: View {
    
    @StateObject private var viewModel = FlickrViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Search", text: $viewModel.searchText)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                            ForEach(viewModel.images, id: \.link) { image in
                                NavigationLink(destination: FlickrViewInDetail(image: image, isShowingDetailView: $viewModel.isShowingDetailView)) {
                                    AsyncImage(url: URL(string: image.media.m)) { image in
                                        image.resizable()
                                    } placeholder: {
                                        Color.gray
                                    }
                                    .frame(width: 100, height: 100)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                }
                            }
                        }
                    }
                }
            }
            .padding()
            .navigationTitle("Flickr Search")
        }
    }
}

#Preview {
    FlickrAppView()
}
