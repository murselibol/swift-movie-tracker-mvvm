//
//  MovieService.swift
//  swift-movie-tracker-mvvm
//
//  Created by Mursel Elibol on 7.05.2023.
//

import Foundation

protocol CastServiceInterface {
    func getCasts(movieId: Int, complete: @escaping((CastsModel?, Error?)->()))
}

class CastService: CastServiceInterface {
    
    //MARK: - Variables
    static let shared = CastService()
    
    //MARK: - Functions

    func getCasts(movieId: Int, complete: @escaping ((CastsModel?, Error?) -> ())) {
        let url = NetworkHelper.shared.requestUrl(url: "movie/\(movieId)/casts")
        NetworkManager.shared.request(type: CastsModel.self, url: url, method: .get) { response in
            switch response {
            case .success(let data):
                complete(data, nil)
            case .failure(let error):
                complete(nil, error)
            }
        }
    }
}
