//
//  SearchBookVC.swift
//  Google Books
//
//  Created by Hivzi on 15.8.22.
//

import UIKit

class SearchBookVC: UIViewController {

    var textInTextField: String?
    @IBOutlet weak var searchTextField: UITextField!
    override func viewDidLoad() {
        searchTextField.delegate = self
        super.viewDidLoad()
    }

    
    @IBAction func get(_ sender: Any) {
        searchTextField.endEditing(true)
    }
}

extension SearchBookVC: UITextFieldDelegate {
    
    // me kete metode textField i tregon VC se return buttoni eshte kliku
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // me endEdditing behet dissmis keyboard
        searchTextField.endEditing(true)
        return true
    }
    
    //me kete metode pyetet delegate se a duhet lejuar te perfundoje editimin
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = " type email address"
            return false
        }
    }
    
    // me kete metode tregohet se perfundon editimi ne kete textfield
    func textFieldDidEndEditing(_ textField: UITextField) {
        // ketu ducase het shkruajtur funksioni per ekzekutim parametrit te dhene ne textfield
        textInTextField = textField.text
        guard textInTextField != nil  else {return}
            performSegue(withIdentifier: "BookList", sender: self)
        
        searchTextField.text = ""
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as? BookListVC
        if segue.identifier == "BookList"  {
            destinationVC?.textInTextField = textInTextField
        }
    }
    
    
    

}
