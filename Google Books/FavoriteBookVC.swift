//
//  FavoriteBookVC.swift
//  Google Books
//
//  Created by Hivzi on 16.8.22.
//

import UIKit

class FavoriteBookVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
   private var favorites = [FavoriteBook]()
    private var items = [Item]()
   var persistence = PersistenceManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundView = UIImageView(image: UIImage(named: "pexels-fwstudio-129731")!)
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32.0).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120.0).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32.0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32.0).isActive = true



    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavoriteBook()
        tableView.reloadData()
    }
    
    func getFavoriteBook() {
      favorites =  persistence.loadBooks()
    }
}
    // MARK: - Table view data source

    extension FavoriteBookVC: UITableViewDelegate, UITableViewDataSource {

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "FavoriteBookCell1", for: indexPath) as? FavoriteBookCell else {return UITableViewCell()}
         DispatchQueue.main.async {
             cell.setup(with: self.favorites[indexPath.row])
         }
         cell.backgroundView = UIImageView(image: UIImage(named: "pexels-fwstudio-129731")!)
         cell.layer.masksToBounds = true
         cell.layer.cornerRadius = 5
         cell.layer.borderWidth = 3
         cell.layer.shadowOffset = CGSize(width: -1, height: 1)
         cell.layer.borderColor = UIColor.black.cgColor
        return cell
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "favoriteToBookInfo", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! BookInfoVC
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.favoriteBook = favorites[indexPath.row]
        }

    }
    
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {return}
        persistence.context.delete(favorites[indexPath.row])
        favorites.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
        
        persistence.saveBooks()
        tableView.reloadData()
    }
    
    // MARK: - Table view delegate

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var cellHeight:CGFloat = CGFloat()
        cellHeight = 122
        return cellHeight
    }
}

