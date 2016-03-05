//
//  MainSettings.swift
//  ParseStarterProject
//
//  Created by Eric Tran on 3/3/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit

class MainSettings: UITableViewController {
    
    
    @IBAction func showProfileSettings(sender: AnyObject) {
        self.performSegueWithIdentifier("showProfileSettings", sender: self)
    }
   
    
    @IBAction func showAccountSettings(sender: AnyObject) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
