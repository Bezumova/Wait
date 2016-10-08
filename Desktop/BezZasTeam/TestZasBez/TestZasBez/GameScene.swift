//
//  GameScene.swift
//  TestZasBez
//
//  Created by xcode on 24.09.16.
//  Copyright © 2016 VSU. All rights reserved.
//

import SpriteKit
import GameplayKit
import UIKit

class GameScene: SKScene {
    
    private var spinnyNode : SKShapeNode?
    var count = 0
    
    func polygonPathLeft() -> CGPath {
        let path = CGMutablePath()
        path.move(to: .init(x: -50, y: 0))
        path.addLine(to: .init(x: 35, y: 0))
        path.addLine(to: .init(x: 165, y: -75))
        path.addLine(to: .init(x: 165, y: -91))
        path.addLine(to: .init(x: 35, y: -16))
        path.addLine(to: .init(x: -50, y: -16))
        path.addLine(to: .init(x: -50, y: 0))
        path.closeSubpath()
        return path
    }
    func polygonPathRight() -> CGPath {
        let path = CGMutablePath()
        path.move(to: .init(x: 50, y: 0))
        path.addLine(to: .init(x: -35, y: 0))
        path.addLine(to: .init(x: -165, y: -75))
        path.addLine(to: .init(x: -165, y: -91))
        path.addLine(to: .init(x: -35, y: -16))
        path.addLine(to: .init(x: 50, y: -16))
        path.addLine(to: .init(x: 50, y: 0))
        path.closeSubpath()
        return path
    }
    
    func poligonMoveLeft() -> SKPhysicsBody {
        let move = SKPhysicsBody(edgeChainFrom: polygonPathLeft())
        move.affectedByGravity=false
        move.isDynamic=false
        return move
    }
    func poligonMoveRight() -> SKPhysicsBody {
        let move = SKPhysicsBody(edgeChainFrom: polygonPathRight())
        move.affectedByGravity=false
        move.isDynamic=false
        return move
    }
    
    
    func drawPath() {
        let pathLeft=polygonPathLeft()
        let shelfLeftUp = SKShapeNode(path: pathLeft)
        shelfLeftUp.position=CGPoint.init(x: -self.size.width/2, y: 120)
        shelfLeftUp.fillColor=SKColor.blue
        shelfLeftUp.strokeColor=shelfLeftUp.fillColor
        addChild(shelfLeftUp)
        shelfLeftUp.physicsBody=poligonMoveLeft()
        
        let shelfLeftDown = SKShapeNode(path: pathLeft)
        shelfLeftDown.position=CGPoint.init(x: -self.size.width/2, y: 0)
        shelfLeftDown.fillColor=shelfLeftUp.fillColor
        shelfLeftDown.strokeColor=shelfLeftDown.fillColor
        addChild(shelfLeftDown)
        shelfLeftDown.physicsBody=poligonMoveLeft()
        
        let pathRight=polygonPathRight()
        let shelfRightUp = SKShapeNode(path: pathRight)
        shelfRightUp.position=CGPoint.init(x: self.size.width/2, y: 120)
        shelfRightUp.fillColor=shelfLeftUp.fillColor
        shelfRightUp.strokeColor=shelfRightUp.fillColor
        addChild(shelfRightUp)
        shelfRightUp.physicsBody=poligonMoveRight()
        
        let shelfRightDown = SKShapeNode(path: pathRight)
        shelfRightDown.position=CGPoint.init(x: self.size.width/2, y: 0)
        shelfRightDown.fillColor=shelfLeftUp.fillColor
        shelfRightDown.strokeColor=shelfRightDown.fillColor
        addChild(shelfRightDown)
        shelfRightDown.physicsBody=poligonMoveRight()
    }
    
    
    override func didMove(to view: SKView) {
        
        let w = self.size.width
        let floor = SKShapeNode.init(rect: CGRect(origin: CGPoint.zero, size: CGSize.init(width: w, height: 32)))
        floor.position = CGPoint(x: -self.size.width/2, y: -214)
        floor.fillColor = SKColor.white
        self.addChild(floor)
        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 2.5
            
        }
        
        let movefloor = SKPhysicsBody(edgeLoopFrom: CGRect(x: -50,y: 32,width: self.frame.size.width+100,height: self.frame.size.height-900))
        
        floor.physicsBody=movefloor
        movefloor.affectedByGravity=false
        movefloor.isDynamic=false
        
        drawPath()
        

    }
    
    func getRandomColor() -> UIColor{
        let randomRed:CGFloat = CGFloat(drand48())
        let randomGreen:CGFloat = CGFloat(drand48())
        let randomBlue:CGFloat = CGFloat(drand48())
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
        
    }

    func getRandomPos() -> CGPoint{
        
        let rLeftUp:CGPoint = CGPoint(x: -self.size.width/2-25, y: 145)
        let rLeftDown:CGPoint = CGPoint(x: -self.size.width/2-25, y: 25)
        let rRightUp:CGPoint = CGPoint(x: self.size.width/2+25, y: 145)
        let rRihgtDown:CGPoint = CGPoint(x: self.size.width/2+25, y: 25)
        let randomPoint = [rLeftUp,rLeftDown,rRightUp,rRihgtDown]
        return randomPoint[Int(arc4random() % UInt32(randomPoint.count))]
        
    }
    
    func drawCircle() {
        let w = (self.size.width + self.size.height) * 0.009
        let n = SKShapeNode.init(circleOfRadius: w)
            n.position = getRandomPos()
            n.fillColor = getRandomColor()
            n.strokeColor = n.fillColor
            self.addChild(n)
        
        let move=SKPhysicsBody.init(circleOfRadius: w)
        n.physicsBody=move
        move.affectedByGravity=true
        move.isDynamic=true
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.drawCircle()
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        count+=1
        if (count%60==0){
        self.drawCircle()
        }
    }
}
