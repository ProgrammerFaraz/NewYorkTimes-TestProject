//
//  NYTimesParameter.swift
//  Test-InnovativeSolutions
//
//  Created by Faraz on 08/08/2024.
//

import Foundation

struct NYTimesParameter {
    let APIKey: String
    
    func toDictionary() -> [String: Any] {
        return ["api-key": APIKey]
    }
    
    static func build(APIKey: String) -> NYTimesParameter {
        return self.init(APIKey: APIKey)
    }
}


