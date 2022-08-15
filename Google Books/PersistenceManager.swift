//
//  PersistenceManager.swift
//  Google Books
//
//  Created by Hivzi on 15.8.22.
//

import UIKit
import CoreData

class PersistenceManager {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    func saveBook(model: Item) {
    let savedBook = FavoriteBook(context: self.context)
        savedBook.title = model.volumeInfo.title
        savedBook.author1 = model.volumeInfo.authors?[0] ?? "N/A"
        savedBook.author2 = model.volumeInfo.authors?[1] ?? ""
        savedBook.publishedDate = model.volumeInfo.publishedDate
        savedBook.publisher = model.volumeInfo.publisher
        
        
    }
}
