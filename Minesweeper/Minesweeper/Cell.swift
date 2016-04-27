//
//  Cell.swift - Model for each cell
//  Minesweeper
//
//  Created by Ankit Kumar on 3/15/16.
//  Copyright © 2016 Ankit Kumar. All rights reserved.
//
import Foundation
import UIKit

class Cell:NSObject {

    dynamic var revealed:Bool = false

    var row:Int!
    var column:Int!
    var isMine:Bool! = false
    var neighbourMines:Int = 0
    
    //computed property for neighbouring cells.
    var neighbourCells:[Cell]?{
        didSet{
            for cell in neighbourCells!{
                if (cell.isMine == true) {
                    ++neighbourMines
                }
            }
        }
    }

    init( row:Int, column:Int){
        self.row = row
        self.column = column
    }
}
