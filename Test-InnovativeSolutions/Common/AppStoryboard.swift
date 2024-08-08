//
//  AppStoryboard.swift
//  Test-InnovativeSolutions
//
//  Created by Faraz on 08/08/2024.
//

import UIKit

enum AppStoryboard : String {
    case Main = "Main"
    var instance : UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
}
