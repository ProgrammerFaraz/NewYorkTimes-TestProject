//
//  NYTimesAPIService.swift
//  Test-InnovativeSolutions
//
//  Created by Faraz on 08/08/2024.
//

import Foundation

protocol NYTimesAPIServiceType {
    func getMostPopular(param: NYTimesParameter, completion: @escaping (Result<MostPopularData, Error>) -> ())
}


class NYTimesAPIService: NYTimesAPIServiceType {
    
    func getMostPopular(param: NYTimesParameter, completion: @escaping (Result<MostPopularData, Error>) -> ()) {
        APIManager.shared.request(target: NYTimesEndpoint.getMostPopular(param), completion: completion)
    }
    
}
