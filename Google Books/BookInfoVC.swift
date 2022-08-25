//
//  BookInfoVC.swift
//  Google Books
//
//  Created by Hivzi on 15.8.22.
//

import UIKit

class BookInfoVC: UIViewController {

    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet  weak var bookTitle: UILabel!
    @IBOutlet weak var descriptonLabel: UILabel!
    @IBOutlet weak var authorsLabel: UILabel!
    @IBOutlet weak var pageLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var publisherlabel: UILabel!
    var author2: String?
    var item: Item?
    var favoriteBook: FavoriteBook?
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
            if let item = item  {
            presentItem(item: item)
            }
            if let favoriteBook = favoriteBook {
                presentFavoriteBook(favoriteBook: favoriteBook)
            }
        
    
    func presentItem(item: Item) {
        bookTitle.text = item.volumeInfo.title
        descriptonLabel.text = item.volumeInfo.description
        pageLabel.text = "page: \(item.volumeInfo.pageCount ?? 0)"
        dateLabel.text =  "Published: \(item.volumeInfo.publishedDate ?? "")"
        publisherlabel.text = " Publisher: \(item.volumeInfo.publisher ?? "")"
        
        let author1 = item.volumeInfo.authors?[0]
        if item.volumeInfo.authors?.count == 2 {
        author2 =  item.volumeInfo.authors?[1]
        }
        authorsLabel.text = "by: \(author1 ?? "N/A") \(author2 ?? "")"
        
        NetworkManager.shared.downloadlImage(from: item.volumeInfo.imageLinks?.thumbnail ?? "") { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.bookImage.image = image
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
       
        func presentFavoriteBook(favoriteBook: FavoriteBook) {
            bookTitle.text = favoriteBook.title
            descriptonLabel.text = favoriteBook.descript
            pageLabel.text = "page: \(favoriteBook.pageNumber ?? 0)"
            dateLabel.text =  "Published: \(favoriteBook.publishedDate ?? "")"
            publisherlabel.text = " Publisher: \(favoriteBook.publisher ?? "")"
             let author1 = favoriteBook.author1 ?? "N/A"
             let author2 =  favoriteBook.author2 ?? ""
            authorsLabel.text = "by: \(author1) \( author2)"
                
                NetworkManager.shared.downloadlImage(from: favoriteBook.thumbnail ?? "") { result in
                    switch result {
                    case .success(let image):
                        DispatchQueue.main.async {
                            self.bookImage.image = image
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
            
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let persistence = PersistenceManager()
        guard let item = item else { return }
        persistence.saveBook(item: item)
      
    }
        
    
}
