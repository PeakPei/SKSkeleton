//
//  StartScene.swift
//  SKSkeleton
//
//  Created by Ryan Knightly on 6/19/17.
//  Copyright © 2017 Ryan Knightly. All rights reserved.
//

import SpriteKit
import GameplayKit

class StartScene: SKScene{
    var score: Int = 0
    
    let scoreLabelPosition = CGPoint(x: screenSize.width * 0.5, y: screenSize.height * 0.67)
    let highscoreLabelPosition = CGPoint(x: screenSize.width * 0.5, y: screenSize.height * 0.55)
    let playButtonPosition = CGPoint(x: screenSize.width * 0.5, y: screenSize.height * 0.31)
    let gameNameLabelPosition = CGPoint(x: screenSize.width * 0.5, y: screenSize.height * 0.82)
    let rateButtonPosition = CGPoint(x: screenSize.width * 0.85, y: screenSize.height * 0.1)
    
    
    let scoreFontSize = kScreenScale * 30
    let highscoreFontSize = kScreenScale * 15
    let gameNameLabelFontSize = kScreenScale * 30
    let playButtonSize = screenSize.width * 0.5
    
    var buttons = [RKButton]()
    
    override func didMove(to view: SKView) {
        addBackground()
        addGameNameLabel()
        addScoreLabel()
        addHighscoreLabel()
        addPlayButton()
        addRateButton()
    }
    
    func setScore(newScore: Int) {
        score = newScore
    }
    
    func addBackground() {
        let background = SKSpriteNode(texture: SKTexture(imageNamed: "background.png"), color: .clear, size: self.size)
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        addChild(background)
    }
    
    func addGameNameLabel() {
        let gameNameLabel = SKLabelNode(text: "Game Name")
        gameNameLabel.name = "gameNameLabel"
        gameNameLabel.fontName = fonts.gameName.rawValue
        gameNameLabel.fontColor = UIColor(red: 0.94, green: 0.94, blue: 0.94, alpha: 1)
        gameNameLabel.position = gameNameLabelPosition
        gameNameLabel.fontSize = gameNameLabelFontSize
        addChild(gameNameLabel)
    }
    
    func addScoreLabel() {
        let scoreLabel = RKValueLabel(num: score)
        scoreLabel.position = scoreLabelPosition
        scoreLabel.fontSize = scoreFontSize
        addChild(scoreLabel)
    }
    
    func addHighscoreLabel() {
        let highscoreLabel = RKValueLabel(num: RKUserDefaults.highscore)
        highscoreLabel.setPrefix(newPrefix: "BEST ")
        highscoreLabel.position = highscoreLabelPosition
        highscoreLabel.fontSize = highscoreFontSize
        addChild(highscoreLabel)
    }
    
    func addPlayButton() {
        let playButton = RKButton()
        let buttonImage = SKSpriteNode(
            texture: SKTexture(imageNamed: "playButton.png"),
            color: .clear,
            size: CGSize(width:playButtonSize, height:playButtonSize))
        playButton.addChild(buttonImage)
        buttonImage.run(RKAnimations().breathe(amount: size.width * 0.08, duration: 1.5)) // .1, 2
        playButton.position = playButtonPosition
        addChild(playButton)
        playButton.pressedAction = {
            self.startGame()
        }
        buttons.append(playButton)
    }
    
    func addRateButton() {
        let rateButton = RKButton()
        rateButton.position = rateButtonPosition
        addChild(rateButton)
        
        let rateLabel = SKLabelNode(text: "Rate")
        rateLabel.color = .white
        rateLabel.fontName = fonts.bold.rawValue
        rateLabel.fontSize = kScreenScale * 15
        rateButton.addChild(rateLabel)
        rateButton.pressedAction = {
            iRate.sharedInstance().promptForRating()
        }
        buttons.append(rateButton)
    }
    
    func startGame() {
        //Configure the view
        let skView = view as SKView!
        skView?.isMultipleTouchEnabled = false
        
        //Create and configure the scene
        let scene = GameScene(size: (skView?.bounds.size)!)
        scene.scaleMode = .aspectFill
        
        //Present the scene
        skView?.presentScene(scene, transition: kScreenTransition)
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        for button in buttons {
            button.handlePress(at: pos)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        touchDown(atPoint: pos)
    }
    
    func touchUp(atPoint pos : CGPoint) {
        for button in buttons {
            button.handleRelease(at: pos)
        }
    }
    
    // Called when a notification or other event cancels a touch
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
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
}
