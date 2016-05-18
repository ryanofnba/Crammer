//
//  ViewController.swift
//
//  Copyright 2011-present Parse Inc. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {
    let gradientLayer = CAGradientLayer()

    @IBAction func signInFB(sender: AnyObject) {
        
        let permissions = ["public_profile"]
        
        PFFacebookUtils.logInInBackgroundWithReadPermissions(permissions) {
            
            (user: PFUser?, error: NSError?) -> Void in
            
            if let error = error {
                print(error)
            } else {
                if let user = user {
                    //self.performSegueWithIdentifier("showSigninScreen", sender: self)
                    //print(user)
                    if let interestedInGirls = user["interestedInGirl"] {
                        self.performSegueWithIdentifier("logUserIn", sender: self)
                    } else {
                        self.performSegueWithIdentifier("showSigninScreen", sender: self)
                    }
                }
            }
        }

        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        
        
        if let username = PFUser.currentUser()?.username {
            
            if let interestedInGirl = PFUser.currentUser()?["interestedInGirl"] {
                self.performSegueWithIdentifier("logUserIn", sender: self)
            } else {
                self.performSegueWithIdentifier("showSigninScreen", sender: self)
            }

            
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1
        self.view.backgroundColor = UIColor.blueColor()
        
        // 2
        gradientLayer.frame = self.view.bounds
        
        // 3
        let color1 = UIColor.blueColor().CGColor as CGColorRef
        //let color2 = UIColor(red: 1.0, green: 0, blue: 0, alpha: 1.0).CGColor as CGColorRef
        //let color3 = UIColor.clearColor().CGColor as CGColorRef
        let color4 = UIColor(white: 0.0, alpha: 0.0).CGColor as CGColorRef
        gradientLayer.colors = [color1, color4]
        
        // 4
        gradientLayer.locations = [0.25, 0.75]
        
        // 5
        //self.view.layer.addSublayer(gradientLayer)
        view.layer.insertSublayer(gradientLayer, atIndex: 0)
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

