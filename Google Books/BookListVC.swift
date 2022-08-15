//
//  BookListVC.swift
//  Google Books
//
//  Created by Hivzi on 15.8.22.
//

import UIKit

class BookListVC: UIViewController {

    var books = [Item]()
    var textInTextField: String!
    @IBOutlet weak var colletcionView: UICollectionView!
    
    
    override func viewDidLoad(){
        colletcionView.delegate = self
        colletcionView.dataSource = self
        let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: 200, height: 300)
                colletcionView.collectionViewLayout = layout
        super.viewDidLoad()
        getData()
    }
    
    
    func getData() {
    NetworkManager.shared.getData(for: textInTextField) { result in
        switch result {
        case .success(let books):
            self.books = books
            print(books.count)
            DispatchQueue.main.async {
            self.colletcionView.reloadData()
            }
        case .failure(let error):
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Warning", message: error.rawValue, preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true)
                  }
             }
        }
    }
}

extension BookListVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        books.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCell", for: indexPath) as! BookCell
        cell.setup(with: books[indexPath.row])
        return cell
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        performSegue(withIdentifier: "goToBookInfo", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! BookInfoVC
        if let indexPaths = colletcionView!.indexPathsForSelectedItems {
            destinationVC.item = books[indexPaths[0].row]
            
        }
       }
}

extension BookListVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 270)
    }
    
    
}
