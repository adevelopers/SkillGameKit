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
    var isBackgroundHiden = true

    private var lastUpdateTime : TimeInterval = 0
    
    override func sceneDidLoad() {
        self.lastUpdateTime = 0
        if !isBackgroundHiden { addBackground() }
        addCamera()
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
        let newCamera = SKCameraNode()
        camera = newCamera
        addChild(newCamera)
    }
    
}
