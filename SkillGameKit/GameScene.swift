//
//  GameScene.swift
//  SkillGameKit
//
//  Created by Kirill Khudyakov on 18.07.17.
//  Copyright © 2017 adeveloper. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var background: SKSpriteNode!
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    

    private var lastUpdateTime : TimeInterval = 0
    
    override func sceneDidLoad() {
        self.lastUpdateTime = 0
        addBackground()
        addCamera()
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
    }
    
    func touchMoved(toPoint pos : CGPoint) {
    
    }
    
    func touchUp(atPoint pos : CGPoint) {
    
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first as UITouch! else { return }
        let acceleration: CGFloat = 1
        let location = touch.location(in: self)
        let previousLocation = touch.previousLocation(in: self)
        let translation = CGPoint(x: location.x - previousLocation.x,
                                  y: location.y - previousLocation.y)

        if let camera = camera {
            let pointOfNode = camera.position
            camera.position = CGPoint(x: pointOfNode.x - translation.x * acceleration,
                                      y: pointOfNode.y - translation.y * acceleration)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        // Update entities
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
        
        self.lastUpdateTime = currentTime
    }
}

extension GameScene {
    
    func addBackground() {
        background = SKSpriteNode(imageNamed: "starOnBg")
        addChild(background)
        background.position = .zero
    }
    
}

extension GameScene {
    
    func addCamera() {
        let cam = SKCameraNode()
        camera = cam
        addChild(cam)
    }
    
}
