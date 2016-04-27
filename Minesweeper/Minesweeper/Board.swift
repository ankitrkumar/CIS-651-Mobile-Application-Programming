//
//  Board.swift - Board setup and model
//  Minesweeper
//
//  Created by Ankit Kumar on 3/15/16.
//  Copyright © 2016 Ankit Kumar. All rights reserved.
//

import Foundation
import UIKit

class Board {

    var rows:Int!
    var columns:Int!
    var cells:[[Cell]]!
    var totalMines:Int!

    init( columns:Int, rows: Int) {
        self.rows = rows
        self.columns = columns
        totalMines = 40//Int(self.rows * self.columns / 6)
    }
    
    //randomly generate cells for the game
    private func generateMines(){
        var mineCount:Int = totalMines
        while mineCount > 0{
            let randomRow = Int( arc4random_uniform( UInt32(rows)))
            let randomColumn = Int( arc4random_uniform( UInt32(columns)))

            if (cells[randomRow][randomColumn].isMine == false){
                cells[randomRow][randomColumn].isMine = true
                --mineCount
            }
        }
    }
    
    //generate the numbers for cells aroud the mines
    private func setMineNumbers(){
        for row in 0 ..< self.rows{
            for col in 0 ..< self.columns{
                let cell = cells[row][col]
                cell.neighbourCells = getNeighbourCells(cell)
            }
        }
    }
    
    //create the neighbouring cells
    private func getNeighbourCells( cell:Cell) -> [Cell]{
        let neighbourCellsOffset = [(-1,-1), (0,-1), (1,-1), (-1,0), (1,0),(-1,1), (0,1), (1,1)]

        var neighbourCells:[Cell] = []
        for (columnOffset, rowOffset) in neighbourCellsOffset{
            if let neighbourCell = getCellAt(row:cell.row + rowOffset, column: cell.column + columnOffset){
                neighbourCells.append(neighbourCell)
            }
        }

        return neighbourCells
    }

    //initialize new game
    func newGame(){
        cells = []
        for row in 0 ..< self.rows {
            var cellRow:[Cell] = []
            for col in 0 ..< self.columns {
                let cell = Cell(row: row, column: col)
                cellRow.append(cell)
            }
            cells.append(cellRow)
        }
        
        generateMines()
        setMineNumbers()
    }

    
    //helper getter function for cell at a given spot
    func getCellAt( row row:Int, column:Int) -> Cell?{
        if row >= 0 && column >= 0 && row < rows && column < columns {
            return cells[row][column]
        } else {
            return nil
        }
    }
}
