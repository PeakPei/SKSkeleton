//
//  RKValueLabel.swift
//  AstroLaser
//
//  Created by Ryan Knightly on 3/20/17.
//  Copyright © 2017 Ryan Knightly. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class RKValueLabel: SKLabelNode {
    var number = 0
    var prefix = ""
    var suffix = ""
    
    init(num: Int) {
        super.init()
        
        fontColor = .white
        fontName = fonts.bold.rawValue
        fontSize = kScreenScale * 15
        
        setTo(num)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func increment() {
        setTo(number + 1)
    }
    
    func setTo(_ newNumber: Int) {
        self.number = newNumber
        text = prefix + " " + "\(self.number)" + suffix
    }
    
    func updateText() {
        text = prefix + "\(self.number)" + suffix
    }
    
    func setPrefix(newPrefix: String) {
        prefix = newPrefix
        updateText()
    }
    
    func setSuffix(newSuffix: String) {
        suffix = newSuffix
        updateText()
    }
}
