//
//  MovieService.swift
//  swift-movie-tracker-mvvm
//
//  Created by Mursel Elibol on 7.05.2023.
//

import Foundation

protocol MovieServiceInterface {
    func getMoviesByCategory(categoryName: MovieCategory, complete: @escaping (Result<MoviesModel, ErrorTypes>) -> Void)
    func getMoviesByName(name: String, page: Int, complete: @escaping (Result<MoviesModel, ErrorTypes>) -> Void)
    func getVideos(id: Int, complete: @escaping (Result<MovieVideosModel, ErrorTypes>) -> Void)
    func getMovie(id: Int, complete: @escaping (Result<MovieModel, ErrorTypes>) -> Void)
}

final class MovieService: MovieServiceInterface {

    static let shared = MovieService()
    
    //MARK: - Fetch
    func getMoviesByCategory(categoryName: MovieCategory, complete: @escaping (Result<MoviesModel, ErrorTypes>) -> Void) {
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
        
        NetworkManager.shared.request(type: MoviesModel.self, url: url, method: .get, completion: complete)
    }
    
    func getMoviesByName(name: String, page: Int, complete: @escaping (Result<MoviesModel, ErrorTypes>) -> Void) {
        let url = NetworkHelper.shared.requestUrl(url: "search/movie")+"&query=\(name)&page=\(page)"
        NetworkManager.shared.request(type: MoviesModel.self, url: url, method: .get, completion: complete)
    }
    
    func getVideos(id: Int, complete: @escaping (Result<MovieVideosModel, ErrorTypes>) -> Void) {
        let url = NetworkHelper.shared.requestUrl(url: "movie/\(id)/videos")
        NetworkManager.shared.request(type: MovieVideosModel.self, url: url, method: .get, completion: complete)
    }
    
    //MARK: - Get
    func getMovie(id: Int, complete: @escaping (Result<MovieModel, ErrorTypes>) -> Void) {
        let url = NetworkHelper.shared.requestUrl(url: "movie/\(id)")
        NetworkManager.shared.request(type: MovieModel.self, url: url, method: .get, completion: complete)
    }
}

