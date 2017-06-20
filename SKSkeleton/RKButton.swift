//
//  RKButton.swift
//  AstroLaser
//
//  Created by Ryan Knightly on 5/28/17.
//  Copyright © 2017 Ryan Knightly. All rights reserved.
//

import Foundation
import SpriteKit

class RKButton: SKNode {
    var isAvailable = true
    var pressedAction = {}
    var doesActOnPress = false
    var isPressed = false
    var animationImages: [SKTexture]?
    var playSound: SKAction?
    
    
    override init() {
        super.init()
        self.zPosition = layer.userInterface.rawValue
    }
    
    func pressed() {
        self.alpha = 0.4
        
        if !isPressed {
            
            
            if let animationTextures = animationImages {
                if let displayImage = childNode(withName: "displayImage") as? SKSpriteNode {
                    print("changin texture")
                    let frameTime = TimeInterval(0.017) // was .1
                    let newTextures = Array(animationTextures).dropFirst()
                    displayImage.run(SKAction.animate(with: Array(newTextures), timePerFrame: frameTime))
                }
            }
            
            if let soundAction = playSound {
                run(soundAction)
            }
        }
        isPressed = true
    }
    
    func released() {
        self.alpha = 1.0
        isPressed = false
        
        if let animationTextures = animationImages {
            if let displayImage = childNode(withName: "displayImage") as? SKSpriteNode {
                displayImage.texture = animationTextures.first
            }
        }
    }
    
    func makeAvailable() {
        isAvailable = true
        self.alpha = 1.0
    }
    
    func makeUnavailable() {
        isAvailable = false
        self.alpha = 0.2
    }
    
    func setAvailability(newAvailability: Bool) {
        if newAvailability {
            makeAvailable()
        } else {
            makeUnavailable()
        }
    }
    
    func setAnimationImages(images: [SKTexture]) {
        animationImages = images
    }
    
    func setClickSound(fileName: String) {
        playSound = SKAction.playSoundFileNamed(fileName, waitForCompletion: false)
    }
    
    func contains(p: CGPoint) -> Bool {
        return self.calculateAccumulatedFrame().contains(p)
    }
    
    func handlePress(at p: CGPoint) {
        if !self.isAvailable {
            return
        }
        
        if contains(p) {
            self.pressed()
            if doesActOnPress {
                pressedAction()
            }
        } else {
            self.released()
        }
    }
    
    func handleRelease(at p: CGPoint) {
        if !self.isAvailable {
            return
        }
        if contains(p) && self.isPressed {
            released()
            if (!doesActOnPress) {
                pressedAction()
            }
        }
    }
    
    func refresh() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
