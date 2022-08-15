//
//  Network Manager.swift
//  Google Books
//
//  Created by Hivzi on 15.8.22.
//

import UIKit


class NetworkManager {

static let shared = NetworkManager()
    private let baseUrl = "https://www.googleapis.com/books/v1/volumes?q="
    private let apiKey = "&maxResults=40&AIzaSyDd1Fr2ofIDWF6YIsqwP44to-N8fiPwkKc"
    
    
    func getData(for searchText: String, completionHandler: @escaping (Result<[Item], ErrorMessage>) -> Void) {
        let endpoint = baseUrl + searchText + apiKey
        guard let url = URL(string: endpoint) else {
            completionHandler(.failure(.invalidSearchText))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in

            if let _ = error {
                completionHandler(.failure(.unableToComplete))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completionHandler(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                completionHandler(.failure(.invalidData))
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let book = try decoder.decode(Book.self, from: data)
              
                completionHandler(.success(book.items))
            } catch {
                completionHandler(.failure(.invalidData))
            }
        }

        task.resume()
    }

    
// Download Image
    func downloadlImage(from urlString: String,  completionHandler: @escaping (Result<UIImage, ErrorMessage>) -> Void) {
        guard let url = URL(string: urlString) else {return}
        let task = URLSession.shared.dataTask(with: url) {[weak self] data, response, error in
            guard let self = self else {return}
            if error != nil { return }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data else { return }
            guard let image = UIImage(data: data) else { return }
            completionHandler(.success(image))
        }
        task.resume()
    }
    

}
