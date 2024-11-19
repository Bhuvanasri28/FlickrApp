//
//  FlickrImage.swift
//  FlickrApp
//
//  Created by Bhuvana Ravuri on 11/19/24.
//

import Foundation

struct FlickrResponse: Codable {
    let items: [FlickrImage]
}

struct Media: Codable {
    let m: String
}

struct FlickrImage: Codable {
    let title: String
    let link: String
    let media: Media
    let description: String
    let author: String
    let published: String
    let authorId: String
    let tags: String
    
    var getAuthorName: String {
        let regex = try? NSRegularExpression(pattern: "\\((.*?)\\)", options: [])
        let range = NSRange(author.startIndex..<author.endIndex, in: author)
        if let match = regex?.firstMatch(in: author, options: [], range: range),
           let nameRange = Range(match.range(at: 1), in: author) {
            return String(author[nameRange])
        }
        return author
    }
    
    var formattedDate: String {
        let dateFormatter = ISO8601DateFormatter()
        if let date = dateFormatter.date(from: published) {
            let displayFormatter = DateFormatter()
            displayFormatter.dateStyle = .medium
            displayFormatter.timeStyle = .short
            return displayFormatter.string(from: date)
        }
        return published
    }
}

//Creating this MockData for previews

struct MockData {
    
    static let sampleImage = FlickrImage(
        title: "Beautiful Sunset",
        link: "https://example.com/sunset",
        media: Media(m: "https://via.placeholder.com/150"),
        description: "A breathtaking sunset over the mountains.",
        author: "nobody@flickr.com (\"John Doe\")",
        published: "2023-09-01T12:34:56Z",
        authorId: "12345",
        tags: "sunset mountains"
    )
    
    static let sampleImages: [FlickrImage] = [
        FlickrImage(
            title: "Beautiful Sunset",
            link: "https://example.com/sunset",
            media: Media(m: "https://via.placeholder.com/150"),
            description: "A breathtaking sunset over the mountains.",
            author: "nobody@flickr.com (\"John Doe\")",
            published: "2023-09-01T12:34:56Z",
            authorId: "12345",
            tags: "sunset mountains"
        ),
        FlickrImage(
            title: "City Skyline",
            link: "https://example.com/city",
            media: Media(m: "https://via.placeholder.com/150"),
            description: "A stunning view of the city skyline at night.",
            author: "nobody@flickr.com (\"Jane Smith\")",
            published: "2023-09-02T08:22:34Z",
            authorId: "67890",
            tags: "city skyline night"
        )
    ]
}


