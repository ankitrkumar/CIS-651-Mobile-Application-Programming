//
//  LoginViewController.swift
//  MovieMoves
//
//  Created by Ankit Kumar on 4/23/16.
//  Copyright © 2016 Ankit Kumar. All rights reserved.
//

import UIKit

// MARK: - LoginViewController

class LoginViewController: UIViewController {


    var session : NSURLSession!
    
    // MARK: Outlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errosLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        errosLabel.text = ""
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Actions
    
    @IBAction func loginPressed(sender: AnyObject) {
        TMDBClient.sharedInstance().authenticateWithViewController(self) { (success, errorString) in
            dispatch_async(dispatch_get_main_queue()) {
                if success {
                    self.completeLogin()
                }else {
                    self.displayError(errorString)
                }
            }
        }
    }
    
    // MARK: Login
    
    private func completeLogin() {
        let controller = storyboard!.instantiateViewControllerWithIdentifier("AppNavigationController") as! UINavigationController
        presentViewController(controller, animated: true, completion: nil)
    }
    
}

extension LoginViewController {
    
    private func setUIEnabled(enabled: Bool) {
        loginButton.enabled = enabled
    }
    
    private func displayError(errorString: String?) {
        if let errorString = errorString {
            errosLabel.text = errorString
        }
    }
}
