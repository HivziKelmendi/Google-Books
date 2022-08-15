//
//  Errors.swift
//  Google Books
//
//  Created by Hivzi on 15.8.22.
//

import Foundation

enum  ErrorMessage: String, Error {
    case invalidSearchText = "This text created an invalid request.  Please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
}
