//
//  APIManager.swift
//  Test-InnovativeSolutions
//
//  Created by Faraz on 08/08/2024.
//

import Foundation
import Moya
import SwiftyJSON

protocol EndpointType: TargetType {}

class APIManager {

    static let shared = APIManager()
    
    private init() {}

    func request<T: Decodable, E: EndpointType>(target: E, completion: @escaping (Result<T, Error>) -> ()) {
        
        let provider = MoyaProvider<E>(plugins: [NetworkLoggerPlugin()])
        
        provider.request(target) { result in
            switch result {
            case let .success(response):
                do {
                    print(JSON(response.data))
                    let results = try JSONDecoder().decode(T.self, from: response.data)
                    completion(.success(results))
                } catch let error as NSError {
                    NSLog("Error in read(from:ofType:) domain= \(error.domain), description= \(error.localizedDescription)")
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
