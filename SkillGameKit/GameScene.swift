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
    
    typealias SubstanceType = String
    
    var background: SKSpriteNode!
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    var isBackgroundHiden = true
    var currentPosition: CGPoint = .zero
    var number: Int = 0

    private var lastUpdateTime : TimeInterval = 0
    
    override func didMove(to view: SKView) {
        self.lastUpdateTime = 0
        if !isBackgroundHiden { addBackground() }
        addCamera()
        addSubstanceNodes()
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

extension GameScene {
    
    func addSubstanceNodes() {
        let substance1 = Substance(value: "C",
                                   child: Substance(value: "C",
                                                    child: Substance(value: "C",
                                                                     child: Substance(value: "H"))
        ))
        
        let substance2 = Substance(value: "H", child: substance1)
        
        addSubstanceNode(by: substance1)
        currentPosition = CGPoint(x: -200, y: -100)
        addSubstanceNode(by: substance2)
    }
    
    func addShapeNode(title: String, previousPosition: CGPoint = .zero) {
        var previous: CGPoint = previousPosition
        previous.x += 50
        
        if number%2 == 0 {
            previous.y -= 50
        } else {
            previous.y += 50
        }
        
        let node = SKLabelNode(fontNamed: "American Typewriter")
        node.fontSize = 40
        node.text = title
        let newPosition = previous
        currentPosition = newPosition
        node.position = currentPosition
        let line = UIBezierPath()
        line.move(to: previousPosition)
        line.addLine(to: newPosition)
        line.close()
        let relation = SKShapeNode(path: line.cgPath )
        relation.lineWidth = 4
        addChild(node)
        
        if number > 0 {
            addChild(relation)
        }
        
        number += 1
    }
    
    
    @discardableResult
    func walk(by substance: Substance<SubstanceType>?, render: (Substance<SubstanceType>)->Void = {_ in } ) -> Substance<SubstanceType>? {
        guard let substance = substance else { return nil }
        render(substance)
        return walk(by: substance.child, render: render)
    }
    
    func addSubstanceNode(by substance: Substance<SubstanceType>) {
        number = 0
        walk(by: substance) { [weak self] substance in
            print("\(substance.value)", terminator: "")
            self?.addShapeNode(title: substance.value, previousPosition: (self?.currentPosition)!)
        }
    }
}
