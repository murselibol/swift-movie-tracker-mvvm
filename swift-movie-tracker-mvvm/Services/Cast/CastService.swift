//
//  MovieService.swift
//  swift-movie-tracker-mvvm
//
//  Created by Mursel Elibol on 7.05.2023.
//

import Foundation

protocol CastServiceInterface {
    func getCasts(movieId: Int, complete: @escaping (Result<CastsModel, ErrorTypes>) -> Void)
}

final class CastService: CastServiceInterface {

    static let shared = CastService()

    //MARK: - Fetch
    func getCasts(movieId: Int, complete: @escaping (Result<CastsModel, ErrorTypes>) -> Void) {
        let url = NetworkHelper.shared.requestUrl(url: "movie/\(movieId)/casts")
        NetworkManager.shared.request(type: CastsModel.self, url: url, method: .get, completion: complete)
    }
}
