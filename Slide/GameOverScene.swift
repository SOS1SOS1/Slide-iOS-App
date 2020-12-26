//
//  GameMenuScene.swift
//  Slide
//
//  Created by Shanti Mickens on 3/27/18.
//  Copyright © 2018 kayapps. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverScene: SKScene {
    
    let restartLabel = SKLabelNode(fontNamed: "The Bold Font")
    let homeLabel = SKLabelNode(fontNamed: "The Bold Font")
    let settingsLabel = SKLabelNode(fontNamed: "The Bold Font")
    
    override func didMove(to view: SKView) {
        
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        background.size = self.size
        self.addChild(background)
        
        let gameOverLabel = SKLabelNode(fontNamed: "The Bold Font")
        gameOverLabel.text = "GAME OVER"
        gameOverLabel.position = CGPoint(x: self.size.width/2, y: self.size.height * 0.8)
        gameOverLabel.zPosition = 1
        gameOverLabel.fontColor = barColor
        gameOverLabel.fontSize = 170
        self.addChild(gameOverLabel)
        
        let scoreLabel = SKLabelNode(fontNamed: "The Bold Font")
        scoreLabel.text = "SCORE: \(gameScore)"
        scoreLabel.position = CGPoint(x: self.size.width/2, y: self.size.height * 0.65)
        scoreLabel.zPosition = 1
        scoreLabel.fontSize = 115
        scoreLabel.fontColor = playerColor
        self.addChild(scoreLabel)
        
        //store information even after app has been closed and will stay there until app is deleted
        let defaults = UserDefaults()
        //highScoreNumber is set = to whatever highscore currently is
        var highScoreNumber = defaults.integer(forKey: "highScoreSaved")
        
        //checks if user has set a new highscore
        if gameScore > highScoreNumber {
            //updates value of highScoreNumber and saves it
            highScoreNumber = gameScore
            defaults.set(highScoreNumber, forKey: "highScoreSaved")
        }
        
        let highScoreLabel = SKLabelNode(fontNamed: "The Bold Font")
        highScoreLabel.text = "HIGH SCORE: \(highScoreNumber)"
        highScoreLabel.fontSize = 115
        highScoreLabel.fontColor = playerColor
        highScoreLabel.position = CGPoint(x: self.size.width/2, y: self.size.height * 0.575)
        highScoreLabel.zPosition = 1
        self.addChild(highScoreLabel)
        
        restartLabel.text = "RESTART"
        restartLabel.fontSize = 115
        restartLabel.fontColor = SKColor.white
        restartLabel.position = CGPoint(x: self.size.width/2, y: self.size.height * 0.4)
        restartLabel.zPosition = 2
        self.addChild(restartLabel)
        
        var buttonColor : SKColor
        if (barColor == SKColor.white) {
            if (playerColor == SKColor.white) {
                buttonColor = SKColor.lightGray
            } else {
                buttonColor = playerColor
            }
        } else {
            buttonColor = barColor
        }
        
        let restartButton = SKShapeNode(rectOf: CGSize(width: 575, height: 125), cornerRadius: 10)
        restartButton.fillColor = buttonColor
        restartButton.strokeColor = buttonColor
        restartButton.position = CGPoint(x: self.size.width/2, y: self.size.height * 0.422)
        restartButton.zPosition = 1
        self.addChild(restartButton)
        
        homeLabel.text = "HOME"
        homeLabel.fontSize = 115
        homeLabel.fontColor = SKColor.white
        homeLabel.position = CGPoint(x: self.size.width/2, y: self.size.height * 0.325)
        homeLabel.zPosition = 2
        self.addChild(homeLabel)
        
        let homeButton = SKShapeNode(rectOf: CGSize(width: 575, height: 125), cornerRadius: 10)
        homeButton.fillColor = buttonColor
        homeButton.strokeColor = buttonColor
        homeButton.position = CGPoint(x: self.size.width/2, y: self.size.height * 0.345)
        homeButton.zPosition = 1
        self.addChild(homeButton)
        
        settingsLabel.text = "SETTINGS"
        settingsLabel.fontSize = 115
        settingsLabel.fontColor = SKColor.white
        settingsLabel.position = CGPoint(x: self.size.width/2, y: self.size.height * 0.25)
        settingsLabel.zPosition = 2
        self.addChild(settingsLabel)
        
        let settingsButton = SKShapeNode(rectOf: CGSize(width: 575, height: 125), cornerRadius: 10)
        settingsButton.fillColor = buttonColor
        settingsButton.strokeColor = buttonColor
        settingsButton.position = CGPoint(x: self.size.width/2, y: self.size.height * 0.27)
        settingsButton.zPosition = 1
        self.addChild(settingsButton)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: AnyObject in touches {
            
            let pointOfTouch = touch.location(in: self)
            
            if restartLabel.contains(pointOfTouch) {
                
                currentGameState = gameState.inGame
                
                // resets game score
                gameScore = 0
                
                // changes scenes to game scene
                let sceneToMoveTo = GameScene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let myTransition = SKTransition.fade(withDuration: 0.5)
                self.view!.presentScene(sceneToMoveTo, transition: myTransition)
                
            }
            
            if homeLabel.contains(pointOfTouch) {
                
                currentGameState = gameState.preGame
                
                // resets game score
                gameScore = 0
                
                // changes scenes to home page
                let sceneToMoveTo = GameMenuScene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let myTransition = SKTransition.fade(withDuration: 0.5)
                self.view!.presentScene(sceneToMoveTo, transition: myTransition)
                
            }
            
            if settingsLabel.contains(pointOfTouch) {
                
                // changes scenes to settings screen
                let sceneToMoveTo = GameSettingsScene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let myTransition = SKTransition.fade(withDuration: 0.5)
                self.view!.presentScene(sceneToMoveTo, transition: myTransition)
                
            }
            
        }
        
    }
    
}
