//
//  UserViewController.swift
//  Roshambo
//
//  Created by Ankit Kumar on 4/7/16.
//  Copyright © 2016 Ankit Kumar. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {

    @IBOutlet weak var paperButton: UIButton!
    @IBOutlet weak var rockButton: UIButton!
    @IBOutlet weak var scissorsButton: UIButton!
    
    var usersPlay : Int?
    var aiPlay :Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    func randomChoice() -> Int {
        // Generate a random Int32 using arc4Random
        return Int(arc4random() % 3)
    }

    @IBAction func selected(sender: UIButton) {
        usersPlay = sender.tag
        aiPlay = randomChoice()
        performSegueWithIdentifier("userSelected", sender: self)
    }
    
    func determineWinner(user: Int, ai: Int)->String{
        switch(user,ai)
        {
        case (0,0),(1,1),(2,2):
            return "tie"
        case (0,1),(1,2),(2,0):
            return "ai"
        case (1,0),(2,1),(0,2):
            return "user";
        default:
            "tie"
        }
        return "tie"
    }
    
    func returnValue(val : Int) ->String
    {
        switch(val){
        case 0: return "Rock"
        case 1: return "Paper"
        case 2: return "Scissors"
        default: return ""
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let controller = segue.destinationViewController as! ResultViewController
        
        controller.winner = determineWinner(usersPlay!, ai: aiPlay!)
        controller.usersPlay = returnValue(usersPlay!)
        controller.aiPlay = returnValue(aiPlay!)
        
    }
    
}

