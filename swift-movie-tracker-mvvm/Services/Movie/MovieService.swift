//
//  MovieService.swift
//  swift-movie-tracker-mvvm
//
//  Created by Mursel Elibol on 7.05.2023.
//

import Foundation

protocol MovieServiceInterface {
    func getMoviesByCategory(categoryName: MovieCategory, complete: @escaping((MoviesModel?, Error?)->()))
    func getMoviesByName(name: String, page: Int, complete: @escaping((MoviesModel?, Error?)->()))
    func getVideos(id: Int, complete: @escaping ((MovieVideosModel?, Error?) -> ()))
    func getMovie(id: Int, complete: @escaping((MovieModel?, Error?)->()))
}

final class MovieService: MovieServiceInterface {

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
    
    func getMoviesByName(name: String, page: Int, complete: @escaping ((MoviesModel?, Error?) -> ())) {
        let url = NetworkHelper.shared.requestUrl(url: "search/movie")+"&query=\(name)&page=\(page)"
        NetworkManager.shared.request(type: MoviesModel.self, url: url, method: .get) { response in
            switch response {
            case .success(let data):
                complete(data, nil)
            case .failure(let error):
                complete(nil, error)
            }
        }
    }
    
    func getVideos(id: Int, complete: @escaping ((MovieVideosModel?, Error?) -> ())) {
        let url = NetworkHelper.shared.requestUrl(url: "movie/\(id)/videos")
        NetworkManager.shared.request(type: MovieVideosModel.self, url: url, method: .get) { response in
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
        let url = NetworkHelper.shared.requestUrl(url: "movie/\(id)")
        NetworkManager.shared.request(type: MovieModel.self, url: url, method: .get) { response in
            switch response {
            case .success(let data):
                complete(data, nil)
            case .failure(let error):
                complete(nil, error)
            }
        }
    }
}

