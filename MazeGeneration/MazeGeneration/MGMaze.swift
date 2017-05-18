//
//  Board.swift
//  testingForMazeGame
//
//  Created by Henry on 4/29/17.
//  Copyright © 2017 henrypigg. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

public class MGMaze {
    var cells = [[Cell]]()
    var stackOfCells = [Cell]()
    var widthOfBoard:Int
    var heightOfBoard:Int
    
    public init(window:SKScene, width:Int, height:Int){
        widthOfBoard = width
        heightOfBoard = height
        
        for i in 0..<widthOfBoard {
            var temp = [Cell]()
            for j in 0..<heightOfBoard {
                let tempCell = Cell(x: i, y: j, boardWidth: widthOfBoard, boardHeight: heightOfBoard, screenSize: window.frame)
                temp.append(tempCell)
            }
            cells.append(temp)
        }
        stackOfCells.append(cells[0][0])
        recursiveMaze(current: CGPoint(x: 0, y: 0), window: window)
        
    }
    public func drawBoard(window:SKScene){
        for i in 0..<widthOfBoard {
            for j in 0..<heightOfBoard {
                cells[i][j].drawCell(window: window)
            }
        }
    }
    
    public func checkNeighbors(x:Int,y:Int){
        cells[x][y].neighbors.removeAll()
        if y != 0 && cells[x][y-1].beenVisited==false {
            cells[x][y].neighbors.append(CGPoint(x: x, y: y-1))
        }
        if x != (cells.count-1) && cells[x+1][y].beenVisited==false {
            cells[x][y].neighbors.append(CGPoint(x: x+1, y: y))
        }
        if y != (cells[0].count-1) && cells[x][y+1].beenVisited==false {
            cells[x][y].neighbors.append(CGPoint(x: x, y: y+1))
        }
        if x != 0 && cells[x-1][y].beenVisited==false {
            cells[x][y].neighbors.append(CGPoint(x: x-1, y: y))
        }
    }
    
    public func removeWall(currentCell:CGPoint, newCell:CGPoint) {
        if Int(newCell.x)==Int(currentCell.x) && Int(newCell.y)<Int(currentCell.y) { //next cell is above current cell
            cells[Int(currentCell.x)][Int(currentCell.y)].checkWalls[2]=false //top wall of current cell
            cells[Int(newCell.x)][Int(newCell.y)].checkWalls[0]=false //bottom wall of next cell
        }
        else if Int(newCell.x)>Int(currentCell.x) && Int(newCell.y)==Int(currentCell.y) {//next cell is to the right of current cell
            cells[Int(currentCell.x)][Int(currentCell.y)].checkWalls[1]=false //right wall of current cell
            cells[Int(newCell.x)][Int(newCell.y)].checkWalls[3]=false //left wall of next cell
        }
        else if(Int(newCell.x)==Int(currentCell.x) && Int(newCell.y)>Int(currentCell.y)) {//next cell is below current cell
            cells[Int(currentCell.x)][Int(currentCell.y)].checkWalls[0]=false //bottom wall of current cell
            cells[Int(newCell.x)][Int(newCell.y)].checkWalls[2]=false //top wall of next cell
        }
        else if(Int(newCell.x)<Int(currentCell.x) && Int(newCell.y)==Int(currentCell.y)) {//next cell is to the left of current cell
            cells[Int(currentCell.x)][Int(currentCell.y)].checkWalls[3]=false //left wall of current cell
            cells[Int(newCell.x)][Int(newCell.y)].checkWalls[1]=false //right wall of next cell
        }
    }
    public func recursiveMaze(current:CGPoint, window:SKScene) {
        checkNeighbors(x: Int(current.x), y: Int(current.y))
        
        if cells[Int(current.x)][Int(current.y)].neighbors.count != 0 {
            let upperBound:Int = cells[Int(current.x)][Int(current.y)].neighbors.count
            let randCell = arc4random_uniform(UInt32(upperBound))
            cells[Int(current.x)][Int(current.y)].beenVisited=true
            removeWall(currentCell: current, newCell: CGPoint(x: cells[Int(current.x)][Int(current.y)].neighbors[Int(randCell)].x, y: cells[Int(current.x)][Int(current.y)].neighbors[Int(randCell)].y))
            stackOfCells.append(cells[Int(cells[Int(current.x)][Int(current.y)].neighbors[Int(randCell)].x)][Int(cells[Int(current.x)][Int(current.y)].neighbors[Int(randCell)].y)])
            recursiveMaze(current: CGPoint(x: cells[Int(current.x)][Int(current.y)].neighbors[Int(randCell)].x, y: cells[Int(current.x)][Int(current.y)].neighbors[Int(randCell)].y), window: window)
            
        }
        else if cells[Int(current.x)][Int(current.y)].neighbors.count==0 && stackOfCells.count != 1 {
            cells[Int(current.x)][Int(current.y)].beenVisited = true
            stackOfCells.removeLast()
            recursiveMaze(current: CGPoint(x: stackOfCells[stackOfCells.count-1].xPos, y: stackOfCells[stackOfCells.count-1].yPos), window: window)
            
        }
    }
}
