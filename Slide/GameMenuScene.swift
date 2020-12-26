//
//  GameMenuScene.swift
//  Slide
//
//  Created by Shanti Mickens on 3/29/18.
//  Copyright © 2018 kayapps. All rights reserved.
//

import Foundation
import SpriteKit

class GameMenuScene: SKScene {
    
    //width and height of bars
    var barWidth = 240
    var barHeight = 60
    
    //changes durations depending on level
    var levelDuration = TimeInterval()
    
    //how long it takes the bar to fall down the screen
    var minFallTime = 11
    var maxFallTime = 15
    
    //how fast bar moves from starting point to random point
    let moveSpeed = TimeInterval(1)
    
    let playLabel = SKLabelNode(fontNamed: "The Bold Font")
    
    //cgrect is a rectangle that defines our area
    let gameArea: CGRect
    
    //sets up the scene
    override init(size: CGSize) {
        
        //use this to determine playable width, how wide an area can we see all devices
        let maxAspectRatio: CGFloat = 16.0/9.0
        let playableWidth = size.height / maxAspectRatio
        let margin = (size.width - playableWidth) / 2
        //creates rectangle, where game will be played
        gameArea = CGRect(x: margin, y: 0, width: playableWidth, height: size.height)
        
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //produces random number between range
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    
    override func didMove(to view: SKView) {
        
        let slideLabel = SKLabelNode(fontNamed: "The Bold Font")
        slideLabel.position = CGPoint(x: self.size.width/2, y: self.size.height * 0.8)
        slideLabel.text = "Slide"
        slideLabel.zPosition = 3
        slideLabel.fontSize = 250
        slideLabel.fontColor = playerColor
        self.addChild(slideLabel)
        
        playLabel.position = CGPoint(x: self.size.width/2, y: self.size.height * 0.5)
        playLabel.text = "Tap To Play"
        playLabel.zPosition = 3
        playLabel.fontSize = 125
        playLabel.fontColor = SKColor.lightGray
        playLabel.alpha = 0
        self.addChild(playLabel)
        
        let fadeInAction = SKAction.fadeIn(withDuration: 1)
        playLabel.run(fadeInAction)
        
        let fadeOutAction = SKAction.fadeOut(withDuration: 2)
        let delay = SKAction.wait(forDuration: 4)
        let fadeOut = SKAction.sequence([delay, fadeOutAction])
        playLabel.run(fadeOut)
        
        addBackgroundBars()
        
    }
    
    func addBackgroundBars() {
                
        //creates bar every 2 seconds
        //to run function in sequence have to create SKAction
        let addBar = SKAction.run(createBar)
        //gap between creating new bars
        let waitToAdd = SKAction.wait(forDuration: 2)
        let addSequence = SKAction.sequence([addBar, waitToAdd])
        let addForever = SKAction.repeatForever(addSequence)
        //makes it repeat loop of spawning and waiting forever
        self.run(addForever, withKey: "addingBars")
        
    }
    
    func createBar() {
        
        //uses random functions at beginning to genereate random start/end points within gameArea
        let randomXStart = random(min: gameArea.minX, max: gameArea.maxX)
        
        let bar = SKShapeNode(rectOf: CGSize(width: barWidth, height: barHeight), cornerRadius: 10)
        bar.name = "Bar"
        bar.zPosition = 1
        bar.fillColor = barColor
        bar.strokeColor = barColor
        bar.position = CGPoint(x: randomXStart, y: self.size.height * 1.2)
        self.addChild(bar)
        
        var fallTime = TimeInterval(random(min: CGFloat(minFallTime), max: CGFloat(maxFallTime)))
        let fallBar = SKAction.moveTo(y: -self.size.height * 0.01, duration: fallTime)
        let deleteBar = SKAction.removeFromParent()
        let fallBarSequence = SKAction.sequence([fallBar, deleteBar])
        bar.run(fallBarSequence)
        
        func move()  {
            let randomX = random(min: gameArea.minX, max: gameArea.maxX)
            let moveBar = SKAction.moveTo(x: randomX, duration: moveSpeed)
            bar.run(moveBar)
        }
        
        //moves bar
        let moveBar = SKAction.run(move)
        let moveCount = Int(random(min:10, max:12))
        //gap between creating new bars
        let waitToMove = SKAction.wait(forDuration: 1)
        let moveSequence = SKAction.sequence([moveBar, waitToMove])
        let moveTwelveTimes = SKAction.repeat(moveSequence, count: Int(moveCount))
        //makes it repeat loop of spawning and waiting forever
        self.run(moveTwelveTimes)
        
    }
    
    func startGame() {
        
        currentGameState = gameState.inGame
        
        let fadeOutAction = SKAction.fadeOut(withDuration: 0.5)
        let deleteAction = SKAction.removeFromParent()
        let deleteSequence = SKAction.sequence([fadeOutAction, deleteAction])
        playLabel.run(deleteSequence)
        
        let sceneToMoveTo = GameScene(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        let myTransition = SKTransition.fade(withDuration: 0.5)
        self.view!.presentScene(sceneToMoveTo, transition: myTransition)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if currentGameState == gameState.preGame {
            startGame()
        }
        
    }
    
}
