import SpriteKit

class Player: SKSpriteNode {
    var targetX: CGFloat = 0
    
    var isJumping: Bool = false
    
    func jump(worldNode: SKNode) {
        if isJumping {
            return
        }
        
        for child in self.children {
            if let animal = child as? Animal{
                let currentPos = self.convert(animal.position, to: worldNode.parent!)
                animal.removeFromParent()
                worldNode.addChild(animal)
                
                
                animal.position = worldNode.convert(currentPos, from: worldNode.parent!)
                animal.isRidden = false
                
                animal.position.y -= 50
                
            }
        }
        
        isJumping = true
        let leap = SKAction.scale(to: 1.5, duration: 0.5)
        leap.timingMode = .easeOut
        
        let fall = SKAction.scale(to: 1.0, duration: 0.7)
        fall.timingMode = .easeIn
        
        let sequence = SKAction.sequence([leap,fall])
        
        self.run(sequence){
            self.isJumping = false
        }
    }
    
    func setup() {
        self.color = .green
        self.size = CGSize(width: 40, height: 40)
        self.zPosition = 20
        
    }
        
    func update(sceneSize: CGSize) {
        let distance = targetX - self.position.x
        self.position.x += distance * 0.1
        
        if self.parent != nil && self.parent?.name == "animal" {
            let distanceY = 0 - self.position.y
            self.position.y += distanceY * 0.1
        }
        
        
        if self.parent?.name != "animal" {
            let halfWidth = self.size.width / 2
            let rightLimit = (sceneSize.width / 2) - halfWidth
            let leftLimit = -(sceneSize.width / 2) + halfWidth
            
            if self.position.x > rightLimit {
                self.position.x = rightLimit
            } else if self.position.x < leftLimit {
                self.position.x = leftLimit
            }
        }
        
        
    }
}
