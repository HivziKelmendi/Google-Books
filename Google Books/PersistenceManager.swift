//
//  PersistenceManager.swift
//  Google Books
//
//  Created by Hivzi on 15.8.22.
//

import UIKit
import CoreData

class PersistenceManager {
    
    var favoriteBooks = [FavoriteBook]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    func saveBook(item: Item) {
    let savedBook = FavoriteBook(context: self.context)
        savedBook.title = item.volumeInfo.title
        savedBook.author1 = item.volumeInfo.authors?[0] ?? "N/A"
        
        if item.volumeInfo.authors?.count == 2 {
        savedBook.author2 = item.volumeInfo.authors?[1] ?? ""
        }
        savedBook.publishedDate = item.volumeInfo.publishedDate
        savedBook.publisher = item.volumeInfo.publisher
        savedBook.thumbnail = item.volumeInfo.imageLinks?.thumbnail
        
        do {
            try context.save()
            print("the favorite book is saved")
        } catch {
            print("error saving context \(error)")
        }
    }
    
    
       func loadBooks() -> [FavoriteBook] {
        let request : NSFetchRequest<FavoriteBook > = FavoriteBook.fetchRequest()
        do {
          favoriteBooks = try context.fetch(request)
        } catch {
            print("Error fetching data form context\(error)")
            
        }
      return favoriteBooks
    }
}
