//
//  GameScene.swift
//  Slide
//
//  Created by Shanti Mickens on 2/25/18.
//  Copyright © 2018 kayapps. All rights reserved.
//

import SpriteKit
import GameplayKit

//by declaring it outside of the gameScene we can gain access to it in any scene, like gameOverScene
var gameScore = 0

// determines size of player (the circle)
var playerRadius = 30

// keeps track of player and bar colors
var playerColor = SKColor.white
var barColor = SKColor.red

// keeps track of what stage in the game the user is at
enum gameState {
    
    case preGame
    case inGame
    case postGame
    
}

var currentGameState = gameState.preGame

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    //globally declares score label for score
    let scoreLabel = SKLabelNode(fontNamed: "The Bold Font")
    
    //keeps track of what level we're on
    var levelNumber = 0
    
    //by declaring it out here can access it in different functions
    let player = SKShapeNode(circleOfRadius: CGFloat(playerRadius))
    
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
    
    struct PhysicsCategories {
        
        //4 categories: player, bar, and none
        //use none to keep objects from colliding
        //use finish line to see if bars make it past player
        
        //numbers in binary form
        static let None : UInt32 = 0
        static let Player : UInt32 = 0b1 //1
        static let Bar : UInt32 = 0b10 //2
        
        //use these to assign physicsBody into categories and then
        //only allow certain physicsBody to interact with other physicsBodies
        
    }
    
    //produces random number between range
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    
        //game area is different between iPads and iPhones, so we have to make sure all of the
        //actual game happens in smaller game area of iPhones
    
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
    
    override func didMove(to view: SKView) {
        
        self.physicsWorld.contactDelegate = self

        let background = SKSpriteNode(imageNamed: "background")
        background.size = self.size
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        self.addChild(background)
        
        //fill color of player
        player.fillColor = playerColor
        //outline color of player
        player.strokeColor = playerColor
        //middle screen, 1/5 the way up
        player.position = CGPoint(x: self.size.width/2, y: self.size.height * 0.11)
        //set to 2 since bullet is at 1
        player.zPosition = 2
        //creates physicsBody for player you define physics stuff for it like gravity
        player.physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(playerRadius))
        //turns off gravity for player (! force unwraps it)
        player.physicsBody!.affectedByGravity = false
        //assigns physicsBody player into physicsCategory player
        player.physicsBody!.categoryBitMask = PhysicsCategories.Player
        //don't want it to collide with anything
        player.physicsBody!.collisionBitMask = PhysicsCategories.None
        //allows them to make contact, if player touches enemy, let me know
        player.physicsBody!.contactTestBitMask = PhysicsCategories.Bar
        //makes the player
        self.addChild(player)
        
        scoreLabel.text = "0"
        scoreLabel.fontSize = 125
        scoreLabel.fontColor = playerColor
        //locks it in the center
        scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        scoreLabel.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.925)
        //ensures its always on top
        scoreLabel.zPosition = 100
        self.addChild(scoreLabel)
        
        startNewLevel()
        
    }
    
    func addScore() {
        
        gameScore += 1
        scoreLabel.text = "\(gameScore)"
        
        //makes label bounce so it catches your eye and you know you gained a point
        let scaleUp = SKAction.scale(to: 1.25, duration: 0.2)
        let scaleDown = SKAction.scale(to: 1, duration: 0.2)
        let scaleSequence = SKAction.sequence([scaleUp, scaleDown])
        scoreLabel.run(scaleSequence)
        
        if gameScore == 10 || gameScore == 25 || gameScore == 50 {
            startNewLevel()
        }
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        //runs when two physicsBodies that can make contact make contact
        //contact holds info. about what has made contact (bodyA and bodyB)
        
        //since they could come in different orders
        //bodyA = enemy bodyB = bullet or bodyA = bullet bodyB = enemy
        //this organizes them in category order specified above in PhysicsCategories
        //sets it so whichever has lower category number is set to body1
        //simplifies code and saves time
        
        var body1 = SKPhysicsBody()
        var body2 = SKPhysicsBody()
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            //already in correct numerical order
            body1 = contact.bodyA
            body2 = contact.bodyB
        } else {
            //not in right order, so flip them around
            body1 = contact.bodyB
            body2 = contact.bodyA
        }
        
        if body1.categoryBitMask == PhysicsCategories.Player && body2.categoryBitMask == PhysicsCategories.Bar {
            
            //since player got hit by bar the game is over so the gameState changes to postGame
            currentGameState = .postGame
            
            //removes all actions
            self.removeAllActions()
            
            self.enumerateChildNodes(withName: "Bar") {
                //finds every object with reference name Bar and removes all their actions
                bar, stop in
                bar.removeAllActions()
            }
            
            let freeze = SKAction.wait(forDuration: 1)
            let sceneToMoveTo = GameOverScene(size: self.size)
            sceneToMoveTo.scaleMode = self.scaleMode
            let myTransition = SKTransition.fade(withDuration: 0.5)
            let switchScene = SKAction.run {
                self.view!.presentScene(sceneToMoveTo, transition: myTransition)
            }
            let gameOverSequence = SKAction.sequence([freeze, switchScene])
            self.run(gameOverSequence)
            
        }

    }
    
    func startNewLevel() {
        
        levelNumber += 1
        
        //if creating bars is running, stop it
        if self.action(forKey: "addingBars") != nil {
            self.removeAction(forKey: "addingBars")
        }
        
        switch levelNumber {
        case 1: levelDuration = 3.0
        case 2: levelDuration = 2.5
        case 3: levelDuration = 2.0
        case 4: levelDuration = 1.5
        default: //if it doesn't equal 1 to 4, then something went wrong, so give it a default value
            levelDuration = 2.0
            print("Error: Cannot find level info")
        }
        
        //creates bar every 2 seconds
        //to run function in sequence have to create SKAction
        let addBar = SKAction.run(createBar)
        //gap between creating new bars
        let waitToAdd = SKAction.wait(forDuration: levelDuration)
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
        bar.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: barWidth, height: barHeight))
        bar.physicsBody!.affectedByGravity = false
        bar.physicsBody!.categoryBitMask = PhysicsCategories.Bar
        bar.physicsBody!.collisionBitMask = PhysicsCategories.None
        bar.physicsBody!.contactTestBitMask = PhysicsCategories.Player
        self.addChild(bar)
        
        var fallTime = TimeInterval(random(min: CGFloat(minFallTime), max: CGFloat(maxFallTime)))
        let fallBar = SKAction.moveTo(y: -self.size.height * 0.01, duration: fallTime)
        let deleteBar = SKAction.removeFromParent()
        let point = SKAction.run(addScore)
        let fallBarSequence = SKAction.sequence([fallBar, deleteBar, point])
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
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: AnyObject in touches {
            //where finger moved to
            let pointOfTouch = touch.location(in: self)
            //where finger started
            let previousPointOfTouch = touch.previousLocation(in: self)
            
            //how far finger moved
            let amountDragged = pointOfTouch.x - previousPointOfTouch.x
            
            if currentGameState == .inGame {
                //adds difference to playerBall's position
                player.position.x += amountDragged
            }
            
            //if the player goes past gameArea on left/right bump it back in
            //too far right
            if player.position.x > gameArea.maxX - CGFloat(playerRadius) {
                player.position.x = gameArea.maxX - CGFloat(playerRadius)
            }
            if player.position.x < gameArea.minX + CGFloat(playerRadius) {
                player.position.x = gameArea.minX + CGFloat(playerRadius)
            }
        }
        
    }
    
}
