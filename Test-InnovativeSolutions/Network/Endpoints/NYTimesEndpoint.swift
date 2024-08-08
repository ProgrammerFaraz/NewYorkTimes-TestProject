//
//  NYTimesEndpoint.swift
//  Test-InnovativeSolutions
//
//  Created by Faraz on 08/08/2024.
//

import Foundation
import Moya

enum NYTimesEndpoint {
    case getMostPopular(NYTimesParameter)
}

// MARK: TargetType

extension NYTimesEndpoint: EndpointType {
    var baseURL: URL { URL(string: Constants.baseURL)! }
    var path: String {
        switch self {
        case .getMostPopular:
            return "/mostpopular/v2/mostviewed/all-sections/7.json"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getMostPopular:
            return .get
        }
    }
    
    var task: Task {
        let requestParameters = parameters ?? [:]
        return .requestParameters(parameters: requestParameters, encoding: URLEncoding.default)
    }
    
    var headers: [String: String]? {
        nil
    }
    
    var parameters: [String: Any]? {
        switch self {
        case let .getMostPopular(param):
            return param.toDictionary()
        }
    }
}
