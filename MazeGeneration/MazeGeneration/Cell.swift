//
//  Cell.swift
//  testingForMazeGame
//
//  Created by Henry on 4/29/17.
//  Copyright © 2017 henrypigg. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class Cell {
    var xPos:Int
    var yPos:Int
    var checkWalls = [Bool]()
    
    var walls = [SKSpriteNode]()
    var beenVisited:Bool
    var cellSize:Int
    var neighbors = [CGPoint]()
    var screen:CGRect
    
    
    let lineCategory:UInt32 = 0x1 << 1
    let playerCategory:UInt32 = 0x1 << 0
    
    init(x:Int, y:Int, boardWidth:Int, boardHeight:Int, screenSize:CGRect) {
        xPos = x
        yPos = y
        screen = screenSize
        beenVisited = false
        checkWalls = [true,true,true,true]
        if(boardWidth<boardHeight){
            cellSize = (Int(screen.size.width)-30)/boardWidth
        }else{
            cellSize = (Int(screen.size.height)-30)/boardHeight
        }
        
    }
    
    func drawCell(window:SKScene){
        
        walls.removeAll()
        
        if(checkWalls[0]==true) {
            let topLine = SKSpriteNode(color: SKColor.white, size: CGSize(width: cellSize+5, height: 5))
            topLine.position = CGPoint(x: CGFloat(15+((xPos+1)*cellSize))-screen.size.width/2-CGFloat(cellSize/2), y: CGFloat(15+((yPos+1)*cellSize))-screen.size.height/2)
            topLine.physicsBody = SKPhysicsBody(rectangleOf: topLine.size)
            topLine.physicsBody?.isDynamic = false
            
            topLine.physicsBody?.categoryBitMask = 1
            topLine.physicsBody?.collisionBitMask = 0
            
            walls.append(topLine)
            window.addChild(topLine)
            
        }
        if(checkWalls[1]==true) {
            let rightLine = SKSpriteNode(color: SKColor.white, size: CGSize(width: 5, height: cellSize+5))
            rightLine.position = CGPoint(x: CGFloat(15+((xPos+1)*cellSize))-screen.size.width/2, y: CGFloat(15+((yPos+1)*cellSize))-screen.size.height/2-CGFloat(cellSize/2))
            rightLine.physicsBody = SKPhysicsBody(rectangleOf: rightLine.size)
            rightLine.physicsBody?.isDynamic = false
            
            rightLine.physicsBody?.categoryBitMask = 1
            rightLine.physicsBody?.collisionBitMask = 0
            
            walls.append(rightLine)
            window.addChild(rightLine)
        }
        if(checkWalls[2]==true) {
            let bottomLine = SKSpriteNode(color: SKColor.white, size: CGSize(width: cellSize+5, height: 5))
            bottomLine.position = CGPoint(x: CGFloat(15+((xPos+1)*cellSize))-screen.size.width/2-CGFloat(cellSize/2), y: CGFloat(15+(yPos*cellSize))-screen.size.height/2)
            bottomLine.physicsBody = SKPhysicsBody(rectangleOf: bottomLine.size)
            bottomLine.physicsBody?.isDynamic = false
            
            bottomLine.physicsBody?.categoryBitMask = 1
            bottomLine.physicsBody?.collisionBitMask = 0
            
            walls.append(bottomLine)
            window.addChild(bottomLine)
        }
        if(checkWalls[3]==true) {
            let leftLine = SKSpriteNode(color: SKColor.white, size: CGSize(width: 5, height: cellSize+5))
            leftLine.position = CGPoint(x: CGFloat(15+(xPos*cellSize))-screen.size.width/2, y: CGFloat(15+((yPos+1)*cellSize))-screen.size.height/2-CGFloat(cellSize/2))
            leftLine.physicsBody = SKPhysicsBody(rectangleOf: leftLine.size)
            leftLine.physicsBody?.isDynamic = false
            
            leftLine.physicsBody?.categoryBitMask = 1
            leftLine.physicsBody?.collisionBitMask = 0
            
            walls.append(leftLine)
            window.addChild(leftLine)
        }
    }
    
    
    
}
