//
//  GameScene.swift
//  SKSkeleton
//
//  Created by Ryan Knightly on 6/19/17.
//  Copyright © 2017 Ryan Knightly. All rights reserved.
//

import SpriteKit
import GameplayKit

var gamesPlayed = 0

class GameScene: SKScene, SKPhysicsContactDelegate {
    private var highscoreLabel: RKValueLabel!
    private var scoreLabel: RKValueLabel!
    private var highscoreBlinking = false
    
    override func didMove(to view: SKView) {
        gamesPlayed += 1
        
        addBackground()
        addScoreLabel()
        addHighscoreLabel()
        addPhysicsWorld()
        showPhysics()
    }
    
    func addPhysicsWorld() {
        physicsWorld.contactDelegate = self
    }
    
    func showPhysics() {
        let skView = self.view! as SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.showsPhysics = true
    }
    
    func addBackground() {
        let background = SKSpriteNode(texture: SKTexture(imageNamed: "background.png"), color: .clear, size: self.size)
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = layer.background.rawValue
        addChild(background)
    }
    
    func addHighscoreLabel() {
        // Big highscore label in the welcome screen
        highscoreLabel = RKValueLabel(num: RKUserDefaults.highscore)
        highscoreLabel.position = CGPoint(x: screenWidth * 0.95, y: screenHeight * 0.9)
        highscoreLabel.fontSize = kScreenScale * 10
        highscoreLabel.horizontalAlignmentMode = .right
        highscoreLabel.zPosition = layer.userInterface.rawValue
        highscoreLabel.setPrefix(newPrefix: "Best: ")
        addChild(highscoreLabel)
    }
    
    func blinkHighscoreLabel() {
        let highscoreBlinkLength: CGFloat = 1.0
        highscoreLabel.run(RKAnimations().blinkAnimation(highscoreBlinkLength))
        highscoreBlinking = true
    }
    
    func addScoreLabel() {
        scoreLabel = RKValueLabel(num: 0)
        scoreLabel.position = CGPoint(x: screenWidth * 0.96, y: screenHeight * 0.95)
        scoreLabel.horizontalAlignmentMode = .right
        scoreLabel.fontSize = kScreenScale * 15
        scoreLabel.zPosition = layer.userInterface.rawValue
        addChild(scoreLabel)
    }
    
    func scorePoint() {
        scoreLabel.increment()
        if scoreLabel.number > RKUserDefaults.highscore {
            RKUserDefaults.highscore = scoreLabel.number
            highscoreLabel.setTo(RKUserDefaults.highscore)
            if !highscoreBlinking {
                blinkHighscoreLabel()
            }
        }
    }
    
    func gameOver() {
        if shouldShowInterstitial() {
            showInterstitial()
        }
        
        let gameOverScene = StartScene(size: (scene?.size)!)
        gameOverScene.setScore(newScore: scoreLabel.number)
        gameOverScene.scaleMode = .aspectFill
        scene?.view?.presentScene(gameOverScene, transition: kFastScreenTransition)
        print("Game over")
    }
    
    //# MARK: - Ads
    func showInterstitial() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showInterstitial"), object: nil)
    }
    
    func shouldShowInterstitial() -> Bool {
        print("games played:", gamesPlayed)
        
        var shouldShow = false
        
        if gamesPlayed != 0 {
            if (gamesPlayed % kAdFrequency) == 0 {
                shouldShow = true
            }
        }
        
        return shouldShow
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        // Called when any object contacts another
        print("Contact started")
        print(contact.bodyA.categoryBitMask)
        print(contact.bodyB.categoryBitMask)
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        switch(contactMask) {
        //EX: case bodyType.can.rawValue | bodyType.generationTrigger.rawValue:
            
        default:
            break
        }
        
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        // Called when any object contacts another
        print("Contact started")
        print(contact.bodyA.categoryBitMask)
        print(contact.bodyB.categoryBitMask)
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        switch(contactMask) {
        //EX: case bodyType.can.rawValue | bodyType.boy.rawValue:

        default:
            break
        }
        
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
    }
    
    func touchMoved(toPoint pos : CGPoint) {
    }
    
    func touchUp(atPoint pos : CGPoint) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
