//
//  MovieVideosModel.swift
//  swift-movie-tracker-mvvm
//
//  Created by Mursel Elibol on 13.06.2023.
//

import Foundation

struct MovieVideosModel: Codable {
    let id: Int
    let results: [MovieVideo]
}

struct MovieVideo: Codable {
    let name, key: String
    let site: String
    let size: Int
    let type: String
    let official: Bool
}
