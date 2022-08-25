//
//  BookCell.swift
//  Google Books
//
//  Created by Hivzi on 15.8.22.
//

import UIKit

class BookCell: UICollectionViewCell {
   
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    
    
    func setup(with book: Item) {
        label.text = book.volumeInfo.title
//        downloadlImage(from: book.volumeInfo.imageLinks?.thumbnail ?? "")
        NetworkManager.shared.downloadlImage(from: book.volumeInfo.imageLinks?.thumbnail ?? "") { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
//    func downloadlImage(from urlString: String) {
//        guard let url = URL(string: urlString) else {return}
//        let task = URLSession.shared.dataTask(with: url) {[weak self] data, response, error in
//            guard let self = self else {return}
//            if error != nil { return }
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
//            guard let data = data else { return }
//            guard let image = UIImage(data: data) else { return }
//            DispatchQueue.main.async {
//                self.imageView.image = image
//            }
//        }
//        task.resume()
//    }
    
}
