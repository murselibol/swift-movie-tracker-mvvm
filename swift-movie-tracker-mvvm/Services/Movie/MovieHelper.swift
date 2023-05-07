//
//  MovieHelper.swift
//  swift-movie-tracker-mvvm
//
//  Created by Mursel Elibol on 7.05.2023.
//

import Foundation

enum MovieCategory {
    case popular
    case nowPlaying
    case trending
    case topRated
    case upcoming
}

enum MoviesEndpoint: String {
    case trending = "trending/movie/day"
    case popular = "movie/popular"
    case nowPlaying = "movie/now_playing"
    case topRated = "movie/top_rated"
    case upcoming = "movie/upcoming"
    
    var path: String {
        switch self {
        case .trending:
            return NetworkHelper.shared.requestUrl(url: MoviesEndpoint.trending.rawValue)
        case .popular:
            return NetworkHelper.shared.requestUrl(url: MoviesEndpoint.popular.rawValue)
        case .nowPlaying:
            return NetworkHelper.shared.requestUrl(url: MoviesEndpoint.nowPlaying.rawValue)
        case .topRated:
            return NetworkHelper.shared.requestUrl(url: MoviesEndpoint.topRated.rawValue)
        case .upcoming:
            return NetworkHelper.shared.requestUrl(url: MoviesEndpoint.upcoming.rawValue)
        }
    }
    
}
