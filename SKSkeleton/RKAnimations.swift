//
//  RKTextAnimations.swift
//  AstroLaser
//
//  Created by Ryan Knightly on 3/21/17.
//  Copyright © 2017 Ryan Knightly. All rights reserved.
//

import Foundation
import SpriteKit

class RKAnimations {
    
    func fadeOut(_ duration: CGFloat) -> SKAction {
        let fadeOutAction = SKAction.fadeAlpha(to: 0, duration: TimeInterval(duration))
        return fadeOutAction
    }
    
    func fadeIn(_ duration: CGFloat) -> SKAction {
        let fadeInAction = SKAction.fadeAlpha(to: 1, duration: TimeInterval(duration))
        return fadeInAction
    }
    
    func blinkAnimation(_ duration: CGFloat) -> SKAction {
        let singleBlink = SKAction.sequence([fadeOut(duration/2), fadeIn(duration/2)])
        return SKAction.repeatForever(singleBlink)
    }
    
    func breatheIn(amount: CGFloat, duration: CGFloat) ->SKAction {
        let breatheInAction = SKAction.resize(byWidth: amount, height: amount, duration: TimeInterval(duration))
        return breatheInAction
    }
    
    func breatheOut(amount: CGFloat, duration: CGFloat) -> SKAction {
        let breatheOutAction = SKAction.resize(byWidth: -amount, height: -amount, duration: TimeInterval(duration))
        return breatheOutAction
    }
    
    func breathe(amount: CGFloat, duration: CGFloat) -> SKAction {
        let singleBreath = SKAction.sequence([breatheIn(amount: amount, duration: duration/2),
                                              breatheOut(amount: amount, duration: duration/2)])
        return SKAction.repeatForever(singleBreath)
    }
}

