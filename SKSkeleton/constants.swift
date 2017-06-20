//
//  constants.swift
//  AstroLaser
//
//  Created by Ryan Knightly on 3/18/17.
//  Copyright © 2017 Ryan Knightly. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

// MARK: - Screen
let screenSize = UIScreen.main.bounds
let screenHeight = screenSize.height
let screenWidth = screenSize.width
let kScreenScale: CGFloat = screenSize.height / 320

// Scenes
let kScreenTransition = SKTransition.crossFade(withDuration: 0.6)
let kFastScreenTransition = SKTransition.crossFade(withDuration: 0.3)

// MARK: - Collision detection
enum bodyType: UInt32 {
    case character = 1
}

// zPositions of different game elements
enum layer: CGFloat {
    case background = -1
    case user = 1
    case userInterface = 3
    case secondUserInterface = 4
}

enum fonts: String {
    case cursive = "Variane Script"
    case bold = "Riffic Free"
    case gameName = "Ailerons"
}

let kAppStoreID: UInt = 0 //TODO: Fill out

let kAdFrequency: Int = 3
let kAdAppID: String = "" //TODO: Fill out
let kBannerID: String = "" //TODO: Fill out
let kInterstitialID: String = "" //TODO: Fill out

