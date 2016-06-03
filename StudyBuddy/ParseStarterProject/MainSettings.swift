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

    @IBOutlet weak var cell1: UITableViewCell!
    @IBOutlet weak var cell2: UITableViewCell!
    @IBOutlet weak var cell3: UITableViewCell!
    @IBOutlet weak var cell4: UITableViewCell!
    @IBOutlet weak var cell5: UITableViewCell!
    
    @IBAction func showSwipeScreen(sender: AnyObject) {

    self.performSegueWithIdentifier("showSwipeScreen", sender: self)
    }


    @IBAction func showProfileSettings(sender: AnyObject) {
        self.performSegueWithIdentifier("showProfileSettings", sender: self)
    }

    
    @IBAction func showAccountSettings(sender: AnyObject) {
        self.performSegueWithIdentifier("showMainSettings", sender: self)
        
    }
    
    @IBAction func loggedOut(sender: AnyObject) {
        PFUser.logOut()
        self.performSegueWithIdentifier("loggedOut", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cell1.backgroundColor = UIColor(red: 242/255, green: 236/255, blue: 179/255, alpha: 1.0)
        self.cell2.backgroundColor = UIColor(red: 242/255, green: 236/255, blue: 179/255, alpha: 1.0)
        self.cell3.backgroundColor = UIColor(red: 242/255, green: 236/255, blue: 179/255, alpha: 1.0)
        self.cell4.backgroundColor = UIColor(red: 242/255, green: 236/255, blue: 179/255, alpha: 1.0)
        self.cell5.backgroundColor = UIColor(red: 242/255, green: 236/255, blue: 179/255, alpha: 1.0)
        //navigationController?.navigationBar.barTintColor = UIColor.blueColor()
        self.view.backgroundColor = UIColor(red: 242/255, green: 236/255, blue: 179/255, alpha: 1.0)
        
        navigationController!.navigationBar.barTintColor = UIColor(red: 77/255, green: 161/255, blue: 169/255, alpha: 1.0)

    }
    
  
}
