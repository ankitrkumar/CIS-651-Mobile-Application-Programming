//
//  View.swift
//  DragMeToHellSwift
//
//  Created by Ankit Kumar on 2/12/16.
//  Copyright © 2016 Ankit Kumar. All rights reserved.
//
//This game is based on Lord of The Rings.

//About and how to play this game
//Drag the hobbit across the grid to reach the bottom of the screen without touching any of Sauron's eyes,
//if you touch an eye then the hobbit will turn into an orc. Once you reach the bottom of the screen and have
//successfully dodged all of Sauron's eyes the hobbit will get the ring and become invisible.
//To restart the game... drag the ring out of the last row of the grid

import UIKit

class MyView: UIView {
    
    var dw : CGFloat = 0;  var dh : CGFloat = 0    // width and height of cell
    var x : CGFloat = 0;   var y : CGFloat = 0     // touch point coordinates
    var row : Int = 0;     var col : Int = 0       // selected cell in cell grid
    var inMotion : Bool = false                    // true iff in process of dragging
    var onEvil = false, win = false
    //    let endPoint = CGPointMake(9,9)
    var blockersCreated = false
    var blockerImage: UIImage!
    var hobbitStart = 0
    var hobbitRect =  CGRectMake(0, 0, 0, 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var blockers = [UIImageView]()  //array to store the coordinates (rows and columns) of where the blockers/Sauron's eyes are added
    
    override func drawRect(rect: CGRect) {
        blockerImage = UIImage (named: "sauron.png")
        let context = UIGraphicsGetCurrentContext()!  // obtain graphics context
        // CGContextScaleCTM( context, 0.5, 0.5 )  // shrink into upper left quadrant
        let w = self.bounds.size.width   // w = width of view (in points)
        let h = self.bounds.size.height // h = height of view (in points)
        self.dw = w/10.0                      // dw = width of cell (in points)
        self.dh = h/10.0                      // dh = height of cell (in points)
        if !blockersCreated{
            var okToAddBlocker = true
            let numOfBlockers = Int(arc4random_uniform(5)+15)
            row = Int(arc4random_uniform(10))
            hobbitStart = row
            hobbitRect = CGRectMake(CGFloat(hobbitStart) * self.dw, CGFloat(col) * self.dh, dw, dh)
            while blockers.count <= numOfBlockers//random number of blockers 15-20 on a 10x10 board
            {
                let randomx = CGFloat(arc4random_uniform(UInt32(w)))
                let randomy = CGFloat(arc4random_uniform(UInt32(h)))
                let newSauron = CGPointMake(randomx,randomy)
                let b = addNewBlocker(newSauron)
                for j in blockers
                {
                    //check for all the conditions of placement of the blockers
                    if(!CGRectIntersectsRect(j.frame, b.frame) &&
                        !CGRectIntersectsRect(b.frame, hobbitRect) && CGRectContainsRect(self.frame, b.frame))
                    {
                        okToAddBlocker = true
                    }
                    else
                    {
                        okToAddBlocker = false
                    }
                    
                }
                if okToAddBlocker{
                    blockers.append(b)
                    self.addSubview(b)
                    okToAddBlocker = false
                }
            }
            var i=0.0;//after creating all the blockers, start the animation for each of them with a gap 0.25 seconds each
            for b in blockers {
                performSelector(Selector("beginBlockerAnimation:"), withObject :b, afterDelay:i)
                i+=0.25
            }
            blockersCreated = !blockersCreated
        }
        var img = UIImage(named:"sauron.png")
        
        //uncomment to draw the lines on screen
        //        // draw lines to form a 10x10 cell grid
        //        CGContextBeginPath( context )               // begin collecting drawing operations
        //
        //        for i in 1..<10 {
        //            // draw horizontal grid line
        //            let iF = CGFloat(i)
        //            CGContextMoveToPoint( context, 0, iF*(self.dh) )
        //            CGContextAddLineToPoint( context, w, iF*self.dh )
        //        }
        //
        //        for i in 1..<10 {
        //            // draw vertical grid line
        //            let iFlt = CGFloat(i)
        //            CGContextMoveToPoint( context, iFlt*self.dw, 0 )
        //            CGContextAddLineToPoint( context, iFlt*self.dw, h )
        //        }
        
        //        UIColor.grayColor().setStroke()                        // use gray as stroke color
        //        CGContextDrawPath( context, CGPathDrawingMode.Stroke ) // execute collected drawing ops
        //
        
        // establish bounding box for image
        let tl = self.inMotion ? CGPointMake( self.x, self.y )
            : CGPointMake( CGFloat(row)*self.dw, CGFloat(col)*self.dh )
        
        let imageRect = CGRectMake(tl.x, tl.y, self.dw, self.dh)
        
        // place appropriate image where dragging stopped
        if ( win ) {
            img = UIImage(named:"ring.png")
        }
        else if (onEvil) {
            img = UIImage(named:"orc.png")
        }
        else{
            img = UIImage(named:"hobbit.png")
        }
        img!.drawInRect(imageRect)
    }
    
    // for the established safe points add blockers
    func addNewBlocker(point: CGPoint) -> UIImageView
    {
        let blocker = UIImageView(image:blockerImage)
        blocker.frame = CGRectMake(point.x, point.y, self.dw, self.dh)
        return blocker
    }
    
    //checks when the touch began and performs actions
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        var touchRow, touchCol : Int
        var xy : CGPoint
        
        super.touchesBegan(touches, withEvent: event)
        for t in touches {
            xy = t.locationInView(self)
            self.x = xy.x;  self.y = xy.y
            touchRow = Int(self.x / self.dw);  touchCol = Int(self.y / self.dh)
            self.inMotion = (self.row == touchRow  &&  self.col == touchCol)
        }
    }
    
    //checks for continuing touches and makes changes  hen the the touch coordinates change
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        var touchRow, touchCol : Int
        var xy : CGPoint
        super.touchesMoved(touches, withEvent: event)
        for t in touches {
            xy = t.locationInView(self)
            self.x = xy.x;  self.y = xy.y
            touchRow = Int(self.x / self.dw);  touchCol = Int(self.y / self.dh)
            self.hobbitRect.origin = xy
        }
        if self.inMotion {
            //checking if the angel/hobbit comes into contact with any of the sauron/blocker things
            for po in blockers{
                for t in touches{
                    xy = t.locationInView(self)
                    
                    self.x = xy.x;  self.y = xy.y
                    
                    touchRow = Int(self.x / self.dw);  touchCol = Int(self.y / self.dh)
                    //game logic
                    if checkTouch(xy, blocker: po)
                    {
                        onEvil = true
                        win = false
                        self.backgroundColor = UIColor.redColor()
                    }
                    else if (touchCol == 9 && !onEvil)
                    {
                        win = true
                        self.backgroundColor = UIColor.purpleColor()
                    }
                    else
                    {
                        win = false
                        if !onEvil
                        {
                            self.backgroundColor = UIColor.cyanColor()
                        }
                        else
                        {
                            self.backgroundColor = UIColor.redColor()
                        }
                    }
                }
            }
            self.setNeedsDisplay()   // request view re-draw
        }
    }
    
    //begin animation on given block and define the logic for it.
    func beginBlockerAnimation( blocker: UIImageView )
    {
        let viewHeight = self.bounds.size.height
        UIView.animateWithDuration(5.0,
            delay: 0.0,
            options: [.CurveLinear, .AllowUserInteraction],
            animations: {() in
                blocker.frame = CGRectMake(blocker.frame.origin.x, blocker.frame.origin.y - viewHeight, blocker.frame.size.width, blocker.frame.size.height);
                if self.checkTouch(self.hobbitRect.origin, blocker: blocker)
                {
                    self.onEvil = true
                    self.win = false
                    self.backgroundColor = UIColor.redColor()
                }
                self.setNeedsDisplay();
                
            },
            completion: { (fin : Bool) in self.finishedAnimation(blocker) })
    }
    
    //simple method to chek if the current touch is inside of the frame of a blocker
    func checkTouch(xy: CGPoint, blocker : UIImageView)-> Bool
    {
        return CGRectContainsPoint(blocker.layer.presentationLayer()!.frame, xy)
    }
    
    //after initial animation all bliockers will be animated from the bottom of the screen
    func continueBlockerAnimation( blocker: UIImageView )
    {
        let viewHeight = self.bounds.size.height
        UIView.animateWithDuration(5.0,
            delay: 0.0,
            options: [.CurveLinear, .AllowUserInteraction],
            animations: {() in
                blocker.frame = CGRectMake(blocker.frame.origin.x, blocker.frame.origin.y - viewHeight, blocker.frame.size.width, blocker.frame.size.height)
                
                if self.checkTouch(self.hobbitRect.origin, blocker: blocker)
                {
                    self.onEvil = true
                    self.win = false
                    self.backgroundColor = UIColor.redColor()
                }
                self.setNeedsDisplay();
                
            },
            completion: { (fin : Bool) in self.finishedAnimation(blocker) })
    }
    
    //beginAnimation finishes and calls this function
    func finishedAnimation(context: UIImageView )
    {
        context.frame.origin.y = self.bounds.size.height
        performSelector(Selector("continueBlockerAnimation:"), withObject :context, afterDelay:0.0)
    }
    
    //reacts on touch ended and performs actions
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)
        if self.inMotion {
            var touchRow : Int = 0;  var touchCol : Int = 0
            var xy : CGPoint
            
            for t in touches {
                xy = t.locationInView(self)
                self.x = xy.x;  self.y = xy.y
                touchRow = Int(self.x / self.dw);  touchCol = Int(self.y / self.dh)
                
            }
            self.inMotion = false
            
            self.row = touchRow;  self.col = touchCol
            
            //sets the color of the view depending on the game logic
            if self.col == 9 && !onEvil && win{
                self.backgroundColor = UIColor.purpleColor()
            } else if onEvil{
                self.backgroundColor = UIColor.redColor()
            }else{
                self.backgroundColor = UIColor.cyanColor()
            }
            self.setNeedsDisplay()
        }
    }
    
}
