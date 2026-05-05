//
//  Entities.swift
//  TrialGame_4 iOS
//
//  Created by Amadeus Gavriel on 04/05/26.
//

import SpriteKit

class ScrollingNode: SKSpriteNode {
    var scrollSpeed: CGFloat = 5.0
    
    func setup() {
        
    }
    
    func update(sceneSize: CGSize) {
        self.position.y -= scrollSpeed
        
        if self.position.y <= -sceneSize.height / 2 {
            self.position.y = sceneSize.height / 2 + 50
            self.position.x = CGFloat.random(in: -150...150)
        }
    }
}
// ISOMETRIC
// =====================================
//func update(sceneSize: CGSize) {
//    self.position.y -= scrollSpeed
//    self.position.x -= (scrollSpeed*2)
//    
//    self.zPosition = -self.position.y
//
//    
//    if self.position.y <= -sceneSize.height / 2 {
//        self.position.y = sceneSize.height / 4 + 100
//        self.position.x = sceneSize.width / 4 + 100
//        
//        let offset = CGFloat.random(in: -200...200)
//        self.position.x += offset
//        self.position.y += offset * 3 / 2
//    }
//}
class Rock: ScrollingNode {
    override func setup() {
        self.color = .yellow
        self.size = CGSize(width: 50, height: 50)
        self.name = "obstacle"
        self.scrollSpeed = 5.0
    }
}

class Animal: ScrollingNode {
    var tameProgress: CGFloat = 0
    var rageMeter: CGFloat = 0
    var isRidden: Bool = false
    
    override func setup() {
        self.color = .blue
        self.size = CGSize(width: 60, height: 60)
        self.name = "animal"
        self.scrollSpeed = 6.0
    }
    
    override func update(sceneSize: CGSize) {
        
        
        if !isRidden {
            super.update(sceneSize: sceneSize)
        }
        if isRidden {
            tameProgress += 0.002
            rageMeter += 0.005
            
            if rageMeter >= 1.0 {
                self.color = .red
            }
            else if rageMeter >= 0.5 {
                self.color = .orange
            }
            else {
                self.color = .blue
            }
        }
    }
}

class Buffalo: Animal {
    override func setup() {
        super.setup()
        self.color = .brown
        self.scrollSpeed = 7.0
    }
}

