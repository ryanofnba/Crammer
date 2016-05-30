//
//  MainSettings.swift
//  ParseStarterProject
//
//  Created by Eric Tran on 3/3/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class MainSettings: UITableViewController {

    @IBAction func showSwipeScreen(sender: AnyObject) {

    self.performSegueWithIdentifier("showSwipeScreen", sender: self)
    }


    @IBAction func showProfileSettings(sender: AnyObject) {
        self.performSegueWithIdentifier("showProfileSettings", sender: self)
    }

    
    @IBAction func showAccountSettings(sender: AnyObject) {
        self.performSegueWithIdentifier("showMainSettings", sender: self)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationController?.navigationBar.barTintColor = UIColor.blueColor()
        self.view.backgroundColor = UIColor(red: 242/255, green: 236/255, blue: 179/255, alpha: 1.0)
    }
}
