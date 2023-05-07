//
//  MovieService.swift
//  swift-movie-tracker-mvvm
//
//  Created by Mursel Elibol on 7.05.2023.
//

import Foundation

protocol MovieManagerInterface {
    func getMoviesByCategory(categoryName: MovieCategory, complete: @escaping((MoviesModel?, Error?)->()))
}

class MovieManager: MovieManagerInterface {
    
    //MARK: - Variables
    static let shared = MovieManager()
    
    //MARK: - Fetch
    func getMoviesByCategory(categoryName: MovieCategory, complete: @escaping ((MoviesModel?, Error?) -> ())) {
        var url = ""
        switch categoryName {
        case .nowPlaying:
            url = MoviesEndpoint.nowPlaying.path
        case .popular:
            url = MoviesEndpoint.popular.path
        case .trending:
            url = MoviesEndpoint.trending.path
        case .topRated:
            url = MoviesEndpoint.topRated.path
        case .upcoming:
            url = MoviesEndpoint.upcoming.path
        }
        
        NetworkManager.shared.request(type: MoviesModel.self, url: url, method: .get) { response in
            switch response {
            case .success(let data):
                complete(data, nil)
            case .failure(let error):
                complete(nil, error)
            }
        }
    }
}

