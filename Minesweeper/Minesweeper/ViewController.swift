//
//  ViewController.swift
//  Minesweeper
//
//  Created by Ankit Kumar on 3/15/16.
//  Copyright © 2016 Ankit Kumar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var board:Board!
    var remainingFlagsLabel:UILabel!
    let boardView:UIView! = UIView()
    var startButton : UIButton!
    var win:Bool = false
    var cellButtons:[CellButton]!
    var remainingFlags:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cellButtons = []
        
        //setup start Button
        setupStartButton()
        self.view.addSubview(startButton)
        
        //setup Flag counter label
        setupFlagsLabel()
        self.view.addSubview(remainingFlagsLabel)
        
        //setup the board
        boardView.frame = CGRectMake(1, 0, UIScreen.mainScreen().bounds.width - 2, 0)
        self.view.addSubview( boardView)
        
        //setup and initialize board for a game of 16x16
        board = Board(columns: 16, rows: 16)
        initializeBoard()
    }
    
    func initializeBoard() {
        resetBoard()
    }
    
    //helper function
    func setupStartButton()
    {
        startButton = UIButton(frame: CGRect(x: 0, y: 30, width: 100, height: 40))
        let startImg = UIImage(named: "start.png")
        startButton.center.x = UIScreen.mainScreen().bounds.midX
        startButton.setImage(startImg, forState: .Normal)
        startButton.addTarget(self, action: "newGame:", forControlEvents: .TouchUpInside)
    }
    
    //helper function
    func setupFlagsLabel()
    {
        remainingFlagsLabel = UILabel( frame: CGRect(x: 0, y: 30, width: 80, height: 40))
        remainingFlagsLabel.center.y = startButton.center.y
        remainingFlagsLabel.textColor = .blueColor()
        remainingFlagsLabel.textAlignment = NSTextAlignment.Right
        remainingFlagsLabel.frame.origin.x = UIScreen.mainScreen().bounds.width - remainingFlagsLabel.frame.width - 20
    }
    
    //selector for handling double tap gesture
    func onDoubleTap(sender:AnyObject){
        if let button = sender.view as? CellButton{
            button.reveal()
            checkForWin()
            if button.cell.isMine == true{
                gameOver()
            }
        }
    }
    
    //selector for handling single tap gesture
    func onSingleTap(sender:CellButton){
            if sender.cell.revealed == false{
                sender.toggleFlag()
                --remainingFlags
                remainingFlagsLabel.text = "Flags: " + String( remainingFlags)
            }
    }
    
    //helper function to check if player has won the game
    func checkForWin(){
        
        var openCells = 0
        for button in cellButtons{
            if button.cell.revealed == true{
                ++openCells
            }
        }
        
        if (cellButtons.count - openCells) == board.totalMines{
            win = true
            gameOver()
        }
    }
    
    //alert for game over and displaying the values of all cells when game gets over.
    func gameOver( displayAlert:Bool = true){
        
        var alertMessage:String = ""
        if win == true{
            alertMessage = "You win!"
        } else {
            alertMessage = "You revealed a mine! You lose!"
        }
        
        if displayAlert == true{
            let alertController = UIAlertController(title: "Minesweeper!", message:
                alertMessage, preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        
        
        for button in cellButtons{
            button.enabled = false
        }
    }
    
    //call to reset game
    func newGame( sender:UIButton) {
        self.resetBoard()
    }
    
    //reset the everything for new game
    func resetBoard() {
        remainingFlags = board.totalMines
        remainingFlagsLabel.text = "Flags: " + String( remainingFlags)
        
        board.newGame()
        remainingFlags = board.totalMines
        remainingFlagsLabel.text = "Flags: " + String( remainingFlags)
        win = false
        addButtons()
        setupBoard()
    }
    
    //dynamically add buttons to the view and reister gesture recognizers
    func addButtons(){
        
        for button in cellButtons{
            button.removeFromSuperview()
        }
        
        cellButtons = []
        
        for row in 0 ..< board.rows {
            for col in 0 ..< board.columns {
                let cell:Cell = board.cells[row][col]
                let cellSide:CGFloat = boardView.bounds.width / CGFloat( board.columns)
                let cellSize:CGSize = CGSizeMake(cellSide, cellSide)
                let button:CellButton = CellButton(cell: cell, size: cellSize)
                let doubleTap = UITapGestureRecognizer(target: self, action: "onDoubleTap:")
                doubleTap.numberOfTapsRequired = 2
                button.addGestureRecognizer(doubleTap)
                button.addTarget(self, action: "onSingleTap:", forControlEvents: .TouchUpInside)
                boardView.addSubview(button)
                cellButtons.append(button)
            }
        }
    }
    
    //resize and repostion the board
    func setupBoard(){
        let cellSide:CGFloat = boardView.bounds.width / CGFloat( board.columns)
        boardView.frame.size.height = CGFloat(board.rows) * cellSide
        boardView.frame.origin.y = startButton.frame.height + boardView.frame.size.height/4
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

