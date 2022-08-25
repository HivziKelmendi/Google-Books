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
        savedBook.descript = item.volumeInfo.description
        if item.volumeInfo.authors?.count == 2 {
        savedBook.author2 = item.volumeInfo.authors?[1] ?? ""
        }
        savedBook.pageNumber = Int32(item.volumeInfo.pageCount ?? 0)
        savedBook.publishedDate = item.volumeInfo.publishedDate
        savedBook.publisher = item.volumeInfo.publisher
        savedBook.thumbnail = item.volumeInfo.imageLinks?.thumbnail
        
        saveBooks()
    }
    
    func saveBooks() {
        do {
            try context.save()
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
