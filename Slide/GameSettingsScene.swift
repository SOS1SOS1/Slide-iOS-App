//
//  GameMenuScene.swift
//  Slide
//
//  Created by Shanti Mickens on 3/29/18.
//  Copyright © 2018 kayapps. All rights reserved.
//

import Foundation
import SpriteKit

class GameSettingsScene: SKScene {
    
    //width and height of bars
    var barWidth = 240
    var barHeight = 60
    
    //cgrect is a rectangle that defines our area
    let gameArea: CGRect
    
    // player color options
    var player1 : SKShapeNode
    var player2 : SKShapeNode
    var player3 : SKShapeNode
    var player4 : SKShapeNode
    var player5 : SKShapeNode
    
    // bar color options
    var bar1 : SKShapeNode
    var bar2 : SKShapeNode
    var bar3 : SKShapeNode
    var bar4 : SKShapeNode
    var bar5 : SKShapeNode
    
    // labels
    let playerLabel = SKLabelNode(fontNamed: "The Bold Font")
    let barLabel = SKLabelNode(fontNamed: "The Bold Font")
    
    // button returns user to game over page
    let backButton = SKShapeNode(rectOf: CGSize(width: 275, height: 125), cornerRadius: 10)
    
    //sets up the scene
    override init(size: CGSize) {
        
        //use this to determine playable width, how wide an area can we see all devices
        let maxAspectRatio: CGFloat = 16.0/9.0
        let playableWidth = size.height / maxAspectRatio
        let margin = (size.width - playableWidth) / 2
        //creates rectangle, where game will be played
        gameArea = CGRect(x: margin, y: 0, width: playableWidth, height: size.height)
        
        player1 = SKShapeNode(circleOfRadius: CGFloat(playerRadius))
        player2 = SKShapeNode(circleOfRadius: CGFloat(playerRadius))
        player3 = SKShapeNode(circleOfRadius: CGFloat(playerRadius))
        player4 = SKShapeNode(circleOfRadius: CGFloat(playerRadius))
        player5 = SKShapeNode(circleOfRadius: CGFloat(playerRadius))
        
        bar1 = SKShapeNode(rectOf: CGSize(width: barWidth, height: barHeight), cornerRadius: 10)
        bar2 = SKShapeNode(rectOf: CGSize(width: barWidth, height: barHeight), cornerRadius: 10)
        bar3 = SKShapeNode(rectOf: CGSize(width: barWidth, height: barHeight), cornerRadius: 10)
        bar4 = SKShapeNode(rectOf: CGSize(width: barWidth, height: barHeight), cornerRadius: 10)
        bar5 = SKShapeNode(rectOf: CGSize(width: barWidth, height: barHeight), cornerRadius: 10)
        
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        
        // adds the settings title to the top of the screen
        let titleLabel = SKLabelNode(fontNamed: "The Bold Font")
        titleLabel.position = CGPoint(x: self.size.width/2, y: self.size.height * 0.8)
        titleLabel.text = "Settings"
        titleLabel.zPosition = 3
        titleLabel.fontSize = 175
        titleLabel.fontColor = SKColor.white
        self.addChild(titleLabel)
        
        // creates a label for the player's color options
        playerLabel.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.65)
        playerLabel.text = "Player Color"
        playerLabel.zPosition = 3
        playerLabel.fontSize = 75
        playerLabel.fontColor = SKColor.lightGray
        self.addChild(playerLabel)
        
        // player color option 1 - white
        player1.zPosition = 1
        player1.fillColor = SKColor.white
        player1.strokeColor = SKColor.clear
        player1.lineWidth = 12
        player1.position = CGPoint(x: self.size.width / 4, y: self.size.height * 0.6)
        self.addChild(player1)
        
        // player color option 2 - red
        player2.zPosition = 1
        player2.fillColor = SKColor.red
        player2.strokeColor = SKColor.clear
        player2.lineWidth = 12
        player2.position = CGPoint(x: self.size.width * 3 / 8, y: self.size.height * 0.6)
        self.addChild(player2)
        
        // player color option 3 - light gray
        player3.zPosition = 1
        player3.fillColor = SKColor.lightGray
        player3.strokeColor = SKColor.clear
        player3.lineWidth = 12
        player3.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.6)
        self.addChild(player3)
        
        // player color option 4 - blue
        player4.zPosition = 1
        player4.fillColor = SKColor.blue
        player4.strokeColor = SKColor.clear
        player4.lineWidth = 12
        player4.position = CGPoint(x: self.size.width * 5 / 8, y: self.size.height * 0.6)
        self.addChild(player4)
        
        // player color option 5 - purple
        player5.zPosition = 1
        player5.fillColor = SKColor.purple
        player5.strokeColor = SKColor.clear
        player5.lineWidth = 12
        player5.position = CGPoint(x: self.size.width * 3 / 4, y: self.size.height * 0.6)
        self.addChild(player5)
        
        // creates a label for the bar's color options
        barLabel.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.5)
        barLabel.text = "Bar Color"
        barLabel.zPosition = 2
        barLabel.fontSize = 75
        barLabel.fontColor = SKColor.lightGray
        self.addChild(barLabel)
        
        // bar color option 1 - white
        bar1.zPosition = 1
        bar1.fillColor = SKColor.white
        bar1.strokeColor = SKColor.clear
        bar1.lineWidth = 15
        bar1.position = CGPoint(x: self.size.width * 0.3, y: self.size.height * 0.45)
        self.addChild(bar1)
        
        // bar color option 2 - red
        bar2.zPosition = 1
        bar2.fillColor = SKColor.red
        bar2.strokeColor = SKColor.clear
        bar2.lineWidth = 15
        bar2.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.45)
        self.addChild(bar2)
        
        // bar color option 3 - light gray
        bar3.zPosition = 1
        bar3.fillColor = SKColor.lightGray
        bar3.strokeColor = SKColor.clear
        bar3.lineWidth = 15
        bar3.position = CGPoint(x: self.size.width * 0.7, y: self.size.height * 0.45)
        self.addChild(bar3)
        
        // bar color option 4 - blue
        bar4.zPosition = 1
        bar4.fillColor = SKColor.blue
        bar4.strokeColor = SKColor.clear
        bar4.lineWidth = 15
        bar4.position = CGPoint(x: self.size.width * 0.4, y: self.size.height * 0.395)
        self.addChild(bar4)
        
        // bar color option 5 - purple
        bar5.zPosition = 1
        bar5.fillColor = SKColor.purple
        bar5.strokeColor = SKColor.clear
        bar5.lineWidth = 15
        bar5.position = CGPoint(x: self.size.width * 0.6, y: self.size.height * 0.395)
        self.addChild(bar5)
        
        // sets current player colors stroke color
        if (playerColor == SKColor.white) {
            player1.strokeColor = SKColor.white
        } else if (playerColor == SKColor.red) {
            player2.strokeColor = SKColor.red
        } else if (playerColor == SKColor.lightGray) {
            player3.strokeColor = SKColor.lightGray
        } else if (playerColor == SKColor.blue) {
            player4.strokeColor = SKColor.blue
        } else if (playerColor == SKColor.purple) {
            player5.strokeColor = SKColor.purple
        }
        
        // sets current bar colors stroke color
        if (barColor == SKColor.white) {
            bar1.strokeColor = SKColor.white
        } else if (barColor == SKColor.red) {
            bar2.strokeColor = SKColor.red
        } else if (barColor == SKColor.lightGray) {
            bar3.strokeColor = SKColor.lightGray
        } else if (barColor == SKColor.blue) {
            bar4.strokeColor = SKColor.blue
        } else if (barColor == SKColor.purple) {
            bar5.strokeColor = SKColor.purple
        }
        
        let fadeInAction = SKAction.fadeIn(withDuration: 1)
        barLabel.run(fadeInAction)
        playerLabel.run(fadeInAction)
        
        // adds a back button
        let backLabel = SKLabelNode(fontNamed: "The Bold Font")
        backLabel.text = "BACK"
        backLabel.fontSize = 90
        backLabel.fontColor = SKColor.white
        backLabel.position = CGPoint(x: self.size.width/4, y: self.size.height * 0.1)
        backLabel.zPosition = 2
        self.addChild(backLabel)
        
        backButton.fillColor = SKColor.lightGray
        backButton.strokeColor = SKColor.lightGray
        backButton.position = CGPoint(x: self.size.width/4, y: self.size.height * 0.117)
        backButton.zPosition = 1
        self.addChild(backButton)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: AnyObject in touches {
            
            let pointOfTouch = touch.location(in: self)
            
            if player1.contains(pointOfTouch) || player2.contains(pointOfTouch) || player3.contains(pointOfTouch) || player4.contains(pointOfTouch) || player5.contains(pointOfTouch) {
                
                // user wants to change player's ("the circle's") color
                player1.strokeColor = SKColor.clear
                player2.strokeColor = SKColor.clear
                player3.strokeColor = SKColor.clear
                player4.strokeColor = SKColor.clear
                player5.strokeColor = SKColor.clear
                
                if (player1.contains(pointOfTouch)) {
                    player1.strokeColor = SKColor.white
                    playerColor = SKColor.white
                } else if (player2.contains(pointOfTouch)) {
                    player2.strokeColor = SKColor.red
                    playerColor = SKColor.red
                } else if (player3.contains(pointOfTouch)) {
                    player3.strokeColor = SKColor.lightGray
                    playerColor = SKColor.lightGray
                } else if (player4.contains(pointOfTouch)) {
                    player4.strokeColor = SKColor.blue
                    playerColor = SKColor.blue
                } else if (player5.contains(pointOfTouch)) {
                    player5.strokeColor = SKColor.purple
                    playerColor = SKColor.purple
                }
                
            }
            
            if bar1.contains(pointOfTouch) || bar2.contains(pointOfTouch) || bar3.contains(pointOfTouch) || bar4.contains(pointOfTouch) || bar5.contains(pointOfTouch) {
                
                // user wants to change bar's color
                bar1.strokeColor = SKColor.clear
                bar2.strokeColor = SKColor.clear
                bar3.strokeColor = SKColor.clear
                bar4.strokeColor = SKColor.clear
                bar5.strokeColor = SKColor.clear
                
                if (bar1.contains(pointOfTouch)) {
                    bar1.strokeColor = SKColor.white
                    barColor = SKColor.white
                } else if (bar2.contains(pointOfTouch)) {
                    bar2.strokeColor = SKColor.red
                    barColor = SKColor.red
                } else if (bar3.contains(pointOfTouch)) {
                    bar3.strokeColor = SKColor.lightGray
                    barColor = SKColor.lightGray
                } else if (bar4.contains(pointOfTouch)) {
                    bar4.strokeColor = SKColor.blue
                    barColor = SKColor.blue
                } else if (bar5.contains(pointOfTouch)) {
                    bar5.strokeColor = SKColor.purple
                    barColor = SKColor.purple
                }
                
            }
            
            if backButton.contains(pointOfTouch) {
                
                let sceneToMoveTo = GameOverScene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let myTransition = SKTransition.fade(withDuration: 0.5)
                self.view!.presentScene(sceneToMoveTo, transition: myTransition)
                
            }
            
        }
        
    }
    
}
