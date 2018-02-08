//
//  ViewController.swift
//  Tappy Block
//
//  Created by Alan Turing on 2018/02/05.
//  Copyright © 2018 Alan Turing. All rights reserved.
//

import SpriteKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if let view = self.view as! SKView? {
            let scene = GameScene(size: view.bounds.size)
         
            scene.scaleMode = .aspectFill
            
            view.presentScene(scene)
            view.showsFPS = true
            view.showsNodeCount = true
            view.showsPhysics = true
        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

