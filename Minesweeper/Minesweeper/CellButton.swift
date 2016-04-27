//
//  CellButton.swift - modified button for exhibiting various properties.
//  Minesweeper
//
//  Created by Ankit Kumar on 3/15/16.
//  Copyright © 2016 Ankit Kumar. All rights reserved.
//
import UIKit

class CellButton: UIButton {
    var cell:Cell!
    
    //init the properties of the cells button.
    init(cell:Cell, size:CGSize){
        let origin = CGPoint(x: CGFloat(cell.column) * size.width, y: CGFloat(cell.row) * size.height)
        super.init(frame: CGRect(origin: origin, size: size))
        self.cell = cell
        self.setImage( UIImage(named: "cell"), forState: .Normal)

        if self.cell.isMine == true{
            self.setBackgroundImage(UIImage(named: "mine"), forState: .Normal)
        } else {
            self.setBackgroundImage(UIImage(named: String( cell.neighbourMines)), forState: .Normal)
        }

        self.cell.addObserver(self, forKeyPath: "revealed", options: .New, context: nil)
    }

    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {

        if keyPath == "revealed"{
            self.setImage(nil , forState: .Normal)

            for neighbourCell in cell.neighbourCells!{
                if neighbourCell.isMine == false &&
                    neighbourCell.neighbourMines == 0 &&
                    neighbourCell.revealed == false  {
                    neighbourCell.revealed = true
                }
            }
        }
    }

    func reveal(){
        self.cell.revealed = true
    }
    
    //toggle flag from flag to no flag based on revealed boolean value
    func toggleFlag(){
        if self.cell.revealed == false{
            if self.imageForState(.Normal) == UIImage(named: "cell"){
                self.setImage(UIImage(named: "flag") , forState: .Normal)
            } else {
                self.setImage(UIImage(named: "cell") , forState: .Normal)
            }
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
