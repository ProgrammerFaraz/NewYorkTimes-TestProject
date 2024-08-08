//
//  HomeViewModel.swift
//  Test-InnovativeSolutions
//
//  Created by Faraz on 08/08/2024.
//

import Foundation

class HomeViewModel {
    
    let nyTimeService: NYTimesAPIServiceType
    var updateData: ((MostPopularData)->Void)?
    var updateError: ((Error)->Void)?
    
    init(nyTimeService: NYTimesAPIServiceType = NYTimesAPIService()) {
        self.nyTimeService = nyTimeService
    }
    
    func getMostPopular() {
        let param = NYTimesParameter.build(APIKey: Constants.NYTimesAPIKey)
        nyTimeService.getMostPopular(param: param) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let data):
                // Handle success
                self.updateData?(data)
            case .failure(let error):
                // Handle error
                self.updateError?(error)
            }
        }
    }
}
