//
//  NetworkHelper.swift
//  swift-movie-tracker-mvvm
//
//  Created by Mursel Elibol on 7.05.2023.
//

import Foundation

enum ErrorTypes: String, Error {
    case invalidData = "Invalid data"
    case invalidURL = "Invalid url"
    case generalError = "An error happened"
}

class NetworkHelper {
    static let shared = NetworkHelper()
        
    private let baseURL = "https://api.themoviedb.org/3/"
    private let apiKey = "9923e05df8d5661186572a8659e8575d"
    private let cdnPath = "https://image.tmdb.org/t/p/original/"
    
    func requestUrl(url: String) -> String {
        return baseURL + url + "?api_key=\(apiKey)"
    }
    
    func getImagePath(url: String) -> String {
        return cdnPath + url
    }
}
