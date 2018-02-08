//
//  GameScene.swift
//  Tappy Block
//
//  Created by Alan Turing on 2018/02/05.
//  Copyright © 2018 Alan Turing. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    let bird = SKSpriteNode(color: UIColor.red, size: CGSize(width: 20.0, height: 20.0))
    let birdFlap = SKAction.moveBy(x: 0.0, y: 50.0, duration: 0.5)
    let birdFall = SKAction.moveBy(x: 0.0, y: -50.0, duration: 0.5)
    
    let wall = SKSpriteNode(color: UIColor.blue, size: CGSize(width: 30.0, height: 300.0))
    let wallMove = SKAction.repeatForever(SKAction.moveBy(x: -20.0, y: 0.0, duration: 0.5))

    override func didMove(to view: SKView) {
        bird.position = CGPoint(x: frame.minX+50, y: frame.midY)
       // bird.physicsBody = SKPhysicsBody(circleOfRadius: bird.size.width/2)
        addChild(bird)
        
        
        
        
        wall.anchorPoint = CGPoint.zero
        wall.position = CGPoint(x: frame.maxX, y: frame.minY)
        addChild(wall)
        wall.run(wallMove)
        
        
    
        
       // physicsWorld.gravity = CGVector(dx: 0.0, dy: 0.2)
       // physicsBody = SKPhysicsBody(edgeChainFrom: CGPath(frame))
        
        bird.run(SKAction.repeatForever(birdFall))

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        bird.run(birdFlap)
        
    }
    
}
