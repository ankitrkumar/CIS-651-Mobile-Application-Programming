//
//  MyView.swift
//  Minesweeper
//
//  Created by Ankit Kumar on 3/24/16.
//  Copyright © 2016 Ankit Kumar. All rights reserved.
//

import UIKit

class MyView: UIView {
    
    var dw : CGFloat = 0;  var dh : CGFloat = 0   	 // width and height of cell
    var x : CGFloat = 0;   var y : CGFloat = 0     // touch point coordinates
    var row : Int = 0;     var col : Int = 0       // selected cell in cell grid
    
    var singleTap = false
    var doubleTap = false
    var touchPoint : CGPoint = CGPointMake(-1, -1)
    var prevTouchPoint : CGPoint = CGPointMake(-1, -1)
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func updatePosition(point: CGPoint)
    {
        self.touchPoint = point
        print(point)
        self.setNeedsDisplay()
    }
    
    func getRowColumn(point: CGPoint) -> CGPoint
    {
        return CGPoint(x: floor(point.x / self.dw), y: floor(point.y / self.dh))
    }
    
    override func drawRect(rect: CGRect) {
        var touchRow, touchCol : CGFloat
        
        let context = UIGraphicsGetCurrentContext()!  // obtain graphics context
        // CGContextScaleCTM( context, 0.5, 0.5 )  // shrink into upper left quadrant
        let bounds = self.bounds          // get view's location and size
        let w = CGRectGetWidth( bounds )   // w = width of view (in points)
        let h = CGRectGetHeight( bounds ) // h = height of view (in points)
        self.dw = w/16.0                      // dw = width of cell (in points)
        self.dh = h/16.0                      // dh = height of cell (in points)
        
        
        
        // draw lines to form a 10x10 cell grid
        CGContextBeginPath( context )               // begin collecting drawing operations
        
        for i in 1..<16 {
            // draw horizontal grid line
            let iF = CGFloat(i)
            CGContextMoveToPoint( context, 0, iF*(self.dh) )
            CGContextAddLineToPoint( context, w, iF*self.dh )
        }
        for i in 1..<16 {
            // draw vertical grid line
            let iFlt = CGFloat(i)
            CGContextMoveToPoint( context, iFlt*self.dw, 0 )
            CGContextAddLineToPoint( context, iFlt*self.dw, h )
        }
        
        print(self.touchPoint)
        UIColor.grayColor().setStroke()                        // use gray as stroke color
        CGContextDrawPath( context, CGPathDrawingMode.Stroke ) // execute collected drawing ops
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.setNeedsDisplay()
    }
}