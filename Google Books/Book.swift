//
//  Book.swift
//  Google Books
//
//  Created by Hivzi on 15.8.22.

import Foundation

struct Book: Codable {
    var items: [Item]
}

struct Item: Codable {
    var volumeInfo: VolumeInfo
}

struct VolumeInfo: Codable {
    var title: String?
     var subtitle: String?
     var authors: [String]?
     var publisher: String?
     var publishedDate: String?
     var description: String?
    var imageLinks: ImageLinks?
    var pageCount: Int?
}

struct ImageLinks: Codable {
      var smallThumbnail: String?
    var  thumbnail: String?
}
