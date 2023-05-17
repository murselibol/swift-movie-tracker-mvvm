//
//  MovieService.swift
//  swift-movie-tracker-mvvm
//
//  Created by Mursel Elibol on 7.05.2023.
//

import Foundation

protocol MovieServiceInterface {
    func getMoviesByCategory(categoryName: MovieCategory, complete: @escaping((MoviesModel?, Error?)->()))
    func getMovie(id: Int, complete: @escaping((MovieModel?, Error?)->()))
}

class MovieService: MovieServiceInterface {
    
    //MARK: - Variables
    static let shared = MovieService()
    
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
    
    //MARK: - Get
    func getMovie(id: Int, complete: @escaping ((MovieModel?, Error?) -> ())) {
        NetworkManager.shared.request(type: MovieModel.self, url: "movie/\(id)", method: .get) { response in
            switch response {
            case .success(let data):
                complete(data, nil)
            case .failure(let error):
                complete(nil, error)
            }
        }
    }
}

