//
//  RKUserDefaults.swift
//  AstroLaser
//
//  Created by Ryan Knightly on 5/29/17.
//  Copyright © 2017 Ryan Knightly. All rights reserved.
//

import Foundation
import UIKit

class RKUserDefaults {
    
    private static let highscoreKey = "highscore"
    private static let hasLoadedBeforeKey = "hasLoadedBefore"
    
    static var hasLoadedBefore: Bool {
        get {
            return UserDefaults.standard.bool(forKey: hasLoadedBeforeKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: hasLoadedBeforeKey)
        }
    }
    
    static var highscore: Int {
        get {
            return UserDefaults.standard.integer(forKey: hasLoadedBeforeKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: hasLoadedBeforeKey)
        }
    }
    
    static func setToInitialValues() {
        RKUserDefaults.highscore = 0
    }
    
}
