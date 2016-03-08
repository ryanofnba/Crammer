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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
