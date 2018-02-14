//
//  GameScene.swift
//  Tappy Block
//
//  Created by Alan Turing on 2018/02/05.
//  Copyright © 2018 Alan Turing. All rights reserved.
//

import SpriteKit


//make a function array of type SKPhysicsContact ?
var contactQueue = [SKPhysicsContact]()

struct PhysicsCategory {
    static let none : UInt32 = 0
    static let all : UInt32 = UInt32.max
    static let bird : UInt32 = 0b1
    static let wall : UInt32 = 0b10
}

class GameScene: SKScene, SKPhysicsContactDelegate {
   
    //Score
    var score = 0
    var hiScore = 0
    
    func updateScore(){
        score+=5
        print(score)
    }
    
    func makeHUD() {
        let scoreLabel = SKLabelNode()

        scoreLabel.position = CGPoint(x: frame.minX+50, y: frame.maxY-50)
        scoreLabel.color = UIColor.white
        scoreLabel.fontName = "Courier"
        scoreLabel.fontSize = 20
        scoreLabel.text = "Score: \(score)"
        addChild(scoreLabel)
        
    }
    //Score - Does Not Refresh Yet
    
    //Randon helper code for generating random numbers
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    //Random
    
    //Wall
    func makeWall() {
        //Define Wall and Movement
        let wall = SKSpriteNode(color: UIColor.blue, size: CGSize(width: 30.0, height: random(min: 200.0, max: 500.0)))
        wall.name = "aWall"
        //test
        print(wall.name!)
        //test
        let wallMove = SKAction.repeatForever(SKAction.moveBy(x: -20.0, y: 0.0, duration: 0.5))
        
        //Set Wall Starting Point
        if random(min: 0, max: 2) > 1 {
            //wall.anchorPoint = CGPoint(x: 0.0, y: 1.0)
            wall.position = CGPoint(x: frame.maxX, y: frame.maxY)
        } else {
            //wall.anchorPoint = CGPoint.zero
            wall.position = CGPoint(x: frame.maxX, y: frame.minY)
        }
        
        //Give walls a physical body for collision detection
        wall.physicsBody = SKPhysicsBody(rectangleOf: wall.size, center: CGPoint(x: 1.0, y: 1.0))
        wall.physicsBody?.isDynamic = true
        wall.physicsBody?.categoryBitMask = PhysicsCategory.wall
        wall.physicsBody?.collisionBitMask = PhysicsCategory.none
        
        
        //Add Wall to Scene, move it, and update score
        addChild(wall)
        wall.run(wallMove)
        updateScore()
    }
    
    func makeWallsForever() {
        run(SKAction.repeatForever(
        SKAction.sequence([
            SKAction.run(makeWall),
            SKAction.wait(forDuration: 4.0, withRange: 1.5)
            ])
        ))
    }
    //Wall
    
    //Player
    let bird = SKSpriteNode(color: UIColor.red, size: CGSize(width: 20.0, height: 20.0))
    let birdFlap = SKAction.moveBy(x: 0.0, y: 50.0, duration: 0.5)
    let birdFall = SKAction.moveBy(x: 0.0, y: -50.0, duration: 0.5)
    //Player

   
    //Main function for executing code
    override func didMove(to view: SKView) {
        
        makeHUD()
        
        bird.position = CGPoint(x: frame.minX+50, y: frame.midY)
        //bird collision detection
        bird.physicsBody = SKPhysicsBody(rectangleOf: bird.size)
        bird.physicsBody?.affectedByGravity = false
        bird.physicsBody?.categoryBitMask = PhysicsCategory.bird
        bird.physicsBody?.collisionBitMask = PhysicsCategory.none
        bird.physicsBody?.contactTestBitMask = PhysicsCategory.wall
        
        addChild(bird)
        bird.run(SKAction.repeatForever(birdFall))
        
        makeWallsForever()
        
       //Enable physics for collision, turn off gravity
        physicsWorld.gravity = CGVector.zero
        physicsWorld.contactDelegate = self
        
        
    }
    //Main
    
    
    //Physics handling
    func didBegin(_ contact: SKPhysicsContact) {
        contactQueue.append(contact)
    }
    
    func handle(_ contact: SKPhysicsContact) {
        if contact.bodyA.node?.parent == nil || contact.bodyB.node?.parent == nil {
            return
        }
        
       
        
        let nodeNames = [contact.bodyA.node!.name!, contact.bodyB.node!.name!]
        
       // for names in nodeNames { print(names)}
        print("collision detection on")
        
        if nodeNames.contains("bird") && nodeNames.contains("aWall") {
            print("hit")
        }
    }
    
    
    
    //Physics
    
    //Touch code gets executed on touch
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        bird.run(birdFlap)
      
    }
    //Touch
    
    func checkContact(forUpdate currentTime: CFTimeInterval) {
        for contact in contactQueue {
            handle(contact)
            
            if let index = contactQueue.index(of: contact){
                contactQueue.remove(at: index)
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        checkContact(forUpdate: currentTime)
    }
}
