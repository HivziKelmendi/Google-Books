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
    var item: Item!
    
        override func viewDidLoad() {
            super.viewDidLoad()
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
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let persistence = PersistenceManager()
        persistence.saveBook(item: item)
      
    }
        
    
}
