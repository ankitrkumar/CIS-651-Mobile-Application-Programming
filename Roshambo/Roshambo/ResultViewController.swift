//
//  ResultViewController.swift
//  Roshambo
//
//  Created by Ankit Kumar on 4/7/16.
//  Copyright © 2016 Ankit Kumar. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet weak var resultImage: UIImageView!
    @IBOutlet weak var resultText: UILabel!
    @IBOutlet weak var playAgain: UIButton!
    
    var winner : String!
    var usersPlay: String!
    var aiPlay: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        UIView.animateWithDuration(5) {
            self.resultImage.alpha = 1
        }

    }
    override func viewWillAppear(animated: Bool) {
        if let winner = winner
        {
            if winner == "ai"
            {
                self.resultText.text = "You loose!\(aiPlay) beats \(usersPlay)"
                print("\(aiPlay)Wins")
                if let aiPlay = self.aiPlay {
                    self.resultImage.image = UIImage(named: "\(aiPlay)Wins")
                } else {
                    self.resultImage.image = nil;
                }
            }
                
            else if winner == "user"
            {
                self.resultText.text = "You win!\(usersPlay) beats \(aiPlay)"
                print("\(usersPlay)Wins")
                if let usersPlay = self.usersPlay {
                    self.resultImage.image = UIImage(named: "\(usersPlay)Wins")
                } else {
                    self.resultImage.image = nil;
                }
                
            }
                
            else if winner == "tie"
            {
                self.resultText.text = "Its a tie!\(usersPlay) ties with \(aiPlay)"
                print("\(winner)")
                if let winner = self.winner {
                    self.resultImage.image = UIImage(named: "\(winner)")
                } else {
                    self.resultImage.image = nil;
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func PlayAgain(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
}


