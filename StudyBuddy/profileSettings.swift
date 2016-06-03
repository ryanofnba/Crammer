//
//  profileSettings.swift
//  ParseStarterProject
//
//  Created by Eric Tran on 3/4/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class profileSettings: UITableViewController {
    let gradientLayer = CAGradientLayer()
    
    @IBOutlet weak var nameField: UILabel!
    @IBOutlet weak var majorField: UILabel!
    @IBOutlet weak var ageField: UILabel!
    @IBOutlet weak var yearField: UILabel!
    
    
    @IBAction func editName(sender: AnyObject) {
        
        let alertController = UIAlertController(title: "Display Name", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        
        let saveAction = UIAlertAction(title: "Save", style: UIAlertActionStyle.Default, handler: {
            alert -> Void in
            
            let firstTextField = alertController.textFields![0] as UITextField
            
            PFUser.currentUser()?["name"] = firstTextField.text
            PFUser.currentUser()?.saveInBackground()
            
            self.nameField.text = PFUser.currentUser()?["name"] as! String
            
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: {
            (action : UIAlertAction!) -> Void in
            
        })
        
        alertController.addTextFieldWithConfigurationHandler { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter First Name"
        }
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    @IBAction func editMajor(sender: AnyObject) {
        
        let alertController = UIAlertController(title: "Major", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        
        let saveAction = UIAlertAction(title: "Save", style: UIAlertActionStyle.Default, handler: {
            alert -> Void in
            
            let firstTextField = alertController.textFields![0] as UITextField
            
            PFUser.currentUser()?["major"] = firstTextField.text
            PFUser.currentUser()?.saveInBackground()
            
            self.majorField.text = PFUser.currentUser()?["major"] as! String
            
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: {
            (action : UIAlertAction!) -> Void in
            
        })
        
        alertController.addTextFieldWithConfigurationHandler { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Major"
        }
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    @IBAction func editAge(sender: AnyObject) {
        let alertController = UIAlertController(title: "Age", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        
        let saveAction = UIAlertAction(title: "Save", style: UIAlertActionStyle.Default, handler: {
            alert -> Void in
            
            let firstTextField = alertController.textFields![0] as UITextField
            
            PFUser.currentUser()?["age"] = firstTextField.text
            PFUser.currentUser()?.saveInBackground()
            
            self.ageField.text = PFUser.currentUser()?["age"] as! String
            
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: {
            (action : UIAlertAction!) -> Void in
            
        })
        
        alertController.addTextFieldWithConfigurationHandler { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Age"
        }
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    @IBAction func editYear(sender: AnyObject) {
        let alertController = UIAlertController(title: "Year", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        
        let saveAction = UIAlertAction(title: "Save", style: UIAlertActionStyle.Default, handler: {
            alert -> Void in
            
            let firstTextField = alertController.textFields![0] as UITextField
            
            PFUser.currentUser()?["year"] = firstTextField.text
            PFUser.currentUser()?.saveInBackground()
            
            self.yearField.text = PFUser.currentUser()?["year"] as! String
            
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: {
            (action : UIAlertAction!) -> Void in
            
        })
        
        alertController.addTextFieldWithConfigurationHandler { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Year"
        }
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    @IBAction func editCourses(sender: AnyObject) {
        let alertController = UIAlertController(title: "Courses Taken", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        
        let saveAction = UIAlertAction(title: "Save", style: UIAlertActionStyle.Default, handler: {
            alert -> Void in
            
            let firstTextField = alertController.textFields![0] as UITextField
            
            PFUser.currentUser()?["classes"] = firstTextField.text
            PFUser.currentUser()?.saveInBackground()
            
            
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: {
            (action : UIAlertAction!) -> Void in
            
        })
        
        alertController.addTextFieldWithConfigurationHandler { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Courses Taken"
        }
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    @IBAction func showMainSettings(sender: AnyObject) {
        self.performSegueWithIdentifier("showMainSettings", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let currentUser = PFUser.currentUser()
        
        print(currentUser?["displayName"])
        
        if let nameText = currentUser!["name"] as? String {
            nameField.text = nameText
        }
        
        if let majorText = currentUser!["major"] as? String {
            majorField.text = majorText
        }
        
        majorField.text = currentUser!["major"] as! String
        ageField.text = currentUser!["age"] as! String
        yearField.text = currentUser!["year"] as! String
        
        //navigationController?.navigationBar.barTintColor = UIColor.blueColor()
        self.view.backgroundColor = UIColor(red: 242/255, green: 236/255, blue: 179/255, alpha: 1.0)
        
        
    }
}
