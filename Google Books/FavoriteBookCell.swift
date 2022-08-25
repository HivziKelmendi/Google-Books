//
//  FavoriteBookCell.swift
//  Google Books
//
//  Created by Hivzi on 16.8.22.
//

import UIKit

class FavoriteBookCell: UITableViewCell {
    
    @IBOutlet weak var favImage: UIImageView!
    
    @IBOutlet weak var favoriteTitle: UILabel!
    
    @IBOutlet weak var favoriteAuthor: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }
    
   
    
    func setup(with favoriteBook: FavoriteBook) {
        favoriteTitle.text = favoriteBook.title
        favoriteAuthor.text =  "by: \(favoriteBook.author1 ?? "") \(favoriteBook.author2 ?? "")"
//        if let photoData = favoriteBook.image as Data? {
//        favImage.image =   UIImage(data: photoData)
//        }
        
        NetworkManager.shared.downloadlImage(from: favoriteBook.thumbnail ?? "") { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.favImage.image = image
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
