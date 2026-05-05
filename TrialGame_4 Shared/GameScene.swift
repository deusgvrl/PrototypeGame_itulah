//
//  GameScene.swift
//  Latch
//
//  Created by Gemini CLI
//

import SpriteKit

/// The main scene for Latch.
/// You will build the scrolling logic and player interaction here.
class GameScene: SKScene {
    
    // MARK: - Properties
    // Define your worldNode and variables here.
    let worldNode = SKNode()
    var gameSpeed: CGFloat = 5.0
    var player : Player!
    
    
    // MARK: - Setup Logic
    
    /// This runs once when the scene is first shown.
    override func didMove(to view: SKView) {
        
        
        // TODO: Initialize your world hierarchy and add nodes.
        self.backgroundColor = .gray
        self.addChild(worldNode)
        
        let rock = Rock()
        rock.setup()
        rock.position = CGPoint(x: 0, y: 0)
        rock.zPosition = 1
    
        
        let animal = Buffalo()
        animal.setup()
        animal.position = CGPoint(x : 0, y: 50)
        animal.zPosition = 1
        
        player = Player()
        player.setup()
        player.position = CGPoint(x: 0, y: -size.height/4)
        
        
        
        self.addChild(player)
        worldNode.addChild(rock)
        worldNode.addChild(animal)
        print(size.height)
        print(size.width)
        
        let wait = SKAction.wait(forDuration: 3.0)
        
        let spawn = SKAction.run {
            [weak self] in
            self?.spawnEntity()
        }
        
        let sequence = SKAction.sequence([wait,spawn])
        let repeatForever = SKAction.repeatForever(sequence)
        
        self.run(repeatForever)
    }
    
    
    // MARK: - Game Loop
    
    /// This runs approximately 60 times per second.
    override func update(_ currentTime: TimeInterval) {
        // TODO: Implement the scrolling treadmill logic here.
        player.update(sceneSize: self.size)
        
        for child in player.children {
            if let animal = child as? Animal {
                animal.update(sceneSize: self.size)
            }
        }
    
        for child in worldNode.children {
            if let node = child as? ScrollingNode {
                node.update(sceneSize: self.size)
                
                if node.position.y < -size.height / 2 - 200 {
                    node.removeFromParent()
                    print("Node Removed from Parent!")
                }
                
                if let animal = node as? Animal {
                    if player.intersects(animal) && !animal.isRidden && player.isJumping {
                        
                        animal.isRidden = true
                        
                        animal.removeFromParent()
                        player.addChild(animal)
                        animal.position = .zero
                        animal.zPosition = -1
                        
                        player.removeAllActions()
                        player.setScale(1.0)
                        player.isJumping = false
                        
                        
                    }
                }
            }
        }
    }
    func spawnEntity() {
        let isAnimal = Bool.random()
        let newNode: ScrollingNode
        
        if isAnimal {
            newNode = Buffalo()
        } else {
            newNode = Rock()
        }
        
        newNode.setup()
        
        let randX = CGFloat.random(in: -200...200)
        newNode.position = CGPoint(x: randX, y: size.height/2 + 100)
        
        worldNode.addChild(newNode)
    }
}



// MARK: - Input Handling
#if os(iOS) || os(tvOS)
extension GameScene {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Start interaction
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Handle steering
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        player.targetX = location.x
        
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Handle jumping
        player.jump(worldNode: worldNode)
    }
}
#endif
