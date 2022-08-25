//
//  BookListVC.swift
//  Google Books
//
//  Created by Hivzi on 15.8.22.
//

import UIKit

class BookListVC: UIViewController {
    var loadingView: UIView!
    var books = [Item]()
    var textInTextField: String!
    var startIndex = 0
    var hasMoreBooks = true
    @IBOutlet weak var colletcionView: UICollectionView!
    
      
    
    override func viewDidLoad(){
        colletcionView.delegate = self
        colletcionView.dataSource = self
        let layout = UICollectionViewFlowLayout()
        colletcionView.collectionViewLayout = layout
        colletcionView.backgroundView = imageView
        
        super.viewDidLoad()
        getData(textInTextField: textInTextField, startIndex: startIndex)
    }
    
    
    func getData(textInTextField: String, startIndex: Int) {
        showLoadingView()
    NetworkManager.shared.getData(for: textInTextField, startIndex: startIndex) {[weak self] result in
        guard let self = self else {return}
        self.dismissLoadingView()
        switch result {
        case .success(let books):
            if books.count < 40 { self.hasMoreBooks = false}
            self.books.append(contentsOf: books)
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
    
    let imageView : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named:"pexels-fwstudio-129733")
        iv.contentMode = .scaleAspectFill
        return iv
    }()

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
    
    // kjo metode duhet per pagination, dhe getData thirret prape nese hasMoreBooks eshte 
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
      let offsetY = scrollView.contentOffset.y
      let contentHeight = scrollView.contentSize.height
      let height = scrollView.frame.size.height
      
      if offsetY > contentHeight - height {
        guard hasMoreBooks else { return }
        startIndex += 40
       getData(textInTextField: textInTextField, startIndex: startIndex)
         }
      }
    
    func showLoadingView() {
        loadingView = UIView(frame: view.bounds)
       view.addSubview(loadingView)
       
        loadingView.backgroundColor = .systemBackground
        loadingView.alpha = 0
       
       UIView.animate(withDuration: 0.25) { self.loadingView.alpha = 0.8 }
       
       let activityIndicator = UIActivityIndicatorView(style: .large)
        loadingView.addSubview(activityIndicator)
       
       activityIndicator.translatesAutoresizingMaskIntoConstraints = false
       NSLayoutConstraint.activate([
         activityIndicator.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor),
         activityIndicator.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor)
       ])
       activityIndicator.startAnimating()
     }
     
     func dismissLoadingView() {
       DispatchQueue.main.async {
         self.loadingView.removeFromSuperview()
         self.loadingView = nil
       }
     }
    
    }

extension BookListVC: UICollectionViewDelegateFlowLayout{
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = colletcionView.bounds.width // width of screen
        let padding: CGFloat = 12
        let minimumItemSpacing: CGFloat = 10
        let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth = availableWidth / 3
        return CGSize(width: itemWidth - 10, height: itemWidth + 40)
    }
   

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 2, left: 8, bottom: 2, right: 8)
    }

}
