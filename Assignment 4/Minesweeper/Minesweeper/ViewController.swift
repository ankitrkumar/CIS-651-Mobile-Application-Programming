//
//  ViewController.swift
//  Minesweeper
//
//  Created by Ankit Kumar on 3/24/16.
//  Copyright © 2016 Ankit Kumar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var gridView: MyView!
    
    @IBAction func handleTap(recognizer:UITapGestureRecognizer)
    {
        gridView.updatePosition(recognizer.locationInView(recognizer.view))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        gridView = MyView()
       
        view.addSubview(gridView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

