//
//  MainSettings.swift
//  ParseStarterProject
//
//  Created by Eric Tran on 2/29/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit

class MainSettings: UIViewController {

    
    @IBOutlet weak var profileSettingsButton: UIButton!
    @IBOutlet weak var accountSettingsButton: UIButton!
    @IBOutlet weak var privacyButton: UIButton!
    @IBOutlet weak var helpButton: UIButton!
    @IBOutlet weak var logoutButton: MainSettings!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction func onTouchProfileSetting(sender: AnyObject) {
        self.performSegueWithIdentifier("showSigninScreen", sender: self)
    }
}
