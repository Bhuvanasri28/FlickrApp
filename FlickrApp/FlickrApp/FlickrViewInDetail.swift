//
//  FlickrViewInDetail.swift
//  FlickrApp
//
//  Created by Bhuvana Ravuri on 11/19/24.
//

import SwiftUI

struct FlickrViewInDetail: View {
    
    var image: FlickrImage
    @Binding var isShowingDetailView : Bool
    @State var isShowingSafari = false
    
    var body: some View {
        VStack(spacing: 20) {
//            HStack {
//                Spacer()
//                Button {
//                    isShowingDetailView = false
//                } label: {
//                    Image(systemName: "xmark")
//                        .frame(width: 50, height: 50)
//                        .foregroundColor(Color(.label))
//                        .imageScale(.large)
//                }
//                .padding()
//            }
            AsyncImage(url: URL(string: image.media.m)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }
            .frame(maxWidth: .infinity, maxHeight: 300)
            
            Text(image.title)
                .font(.title2)
                .fontWeight(.semibold)
            Text(stripHTML(from: image.description))
                .font(.body)
                .multilineTextAlignment(.center)
                .padding()
            Text("Author: \(image.getAuthorName)")
                .font(.subheadline)
            Text("Published on: \(image.formattedDate)")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding()
            //Spacer()
            Button {
                isShowingSafari = true
            } label: {
                Text("Learn More")
                    .fontWeight(.bold)
                    .frame(width: 200, height: 40)
                    .foregroundColor(Color.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
        .fullScreenCover(isPresented: $isShowingSafari, content: {
            SafariView(url: (URL(string: image.link) ?? URL(string: "www.apple.com"))!)
        })
    }
}

func stripHTML(from string: String) -> String {
    let data = Data(string.utf8)
    let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
        .documentType: NSAttributedString.DocumentType.html,
        .characterEncoding: String.Encoding.utf8.rawValue
    ]
    let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil)
    return attributedString?.string ?? string
}

#Preview {
    FlickrViewInDetail(image: MockData.sampleImage, isShowingDetailView: .constant(true))
}
