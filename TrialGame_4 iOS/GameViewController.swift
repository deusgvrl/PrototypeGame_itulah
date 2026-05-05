//
//  GameViewController.swift
//  TrialGame_4 iOS
//
//  Created by Amadeus Gavriel on 01/05/26.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Present the scene
        let skView = self.view as! SKView
        if skView.scene == nil {
            let scene = GameScene(size: CGSize(width: 750, height: 1334))
            scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            scene.scaleMode = .aspectFill
        
            skView.presentScene(scene)
        
            skView.ignoresSiblingOrder = true
            skView.showsFPS = true
            skView.showsNodeCount = true
        }
        
}
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
