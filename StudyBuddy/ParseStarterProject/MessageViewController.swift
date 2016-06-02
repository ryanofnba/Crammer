//
//  MessageViewController.swift
//  ParseStarterProject
//
//  Created by Eric Tran on 3/6/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class MessageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var MessageTextField: UITextField!
    
    @IBOutlet weak var DocViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var SendButton: UIButton!
    
    @IBAction func showSwipeScreen(sender: AnyObject) {
        self.performSegueWithIdentifier("showSwipeScreen", sender: self)
    }

    @IBOutlet weak var messageTableView: UITableView!
    var messageArray:[String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let logo = UIImage(named: "NavBarCrammer.jpg")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        
        // Do any additional setup after loading the view.
        
        self.messageTableView.delegate = self
        self.messageTableView.dataSource = self
        //set self as delegate as text field
        self.MessageTextField.delegate = self
        
        //add a tap gesture to tableview
        let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer(target:self, action: "tableViewTapped")
        self.messageTableView.addGestureRecognizer(tapGesture)
        //Add some sample data so we can see something
        self.messageArray.append("Test 1")
        self.messageArray.append("Test 2")
        self.messageArray.append("Test 3")
        
        navigationController!.navigationBar.barTintColor = UIColor(red: 77/255, green: 161/255, blue: 169/255, alpha: 1.0)
        //navigationController?.navigationBar.barTintColor = UIColor.blueColor()
        self.view.backgroundColor = UIColor(red: 242/255, green: 236/255, blue: 179/255, alpha: 1.0)
        
    }
    @IBAction func SendButtonTapped(sender: UIButton) {
        //send button is tapped
        
        //call end editing method
        self.MessageTextField.endEditing(true)
        
        //create PFObject
        var newMessageObject = PFObject(className:"Messages")
        
        //set text to the text of the message field and save PFObject
        newMessageObject.setObject(self.MessageTextField.text!, forKey: "Text")
        newMessageObject.saveInBackgroundWithBlock(
            {
                (succeeded:Bool, error:NSError?) -> Void in
                if succeeded {
                    NSLog("Object created with id: (newMessageObject.objectId)")
                } else {
                    NSLog(error!.description)
                }
                self.SendButton.enabled = true
                self.MessageTextField.enabled = true
                self.MessageTextField.text = ""
            }
        )
        /**newMessageObject.saveInBackgroundWithBlock {
            (success:Bool, error:NSError!) -> Void in
            if (success == true) {
                // show latest messages and reload table
            }
            else {
                
            }
        }*/
    }
    
    func tableViewTapped() {
        //force text field to end editing
        self.MessageTextField.endEditing(true)
    }
    
    //MARK textField delegate methods
    func textFieldDidBeginEditing(textField: UITextField) {

        self.view.layoutIfNeeded()
        UIView.animateWithDuration(0.5, animations: {
            self.DocViewHeightConstraint.constant = 350
            self.view.layoutIfNeeded()
            
            }, completion: nil)
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        self.view.layoutIfNeeded()
        UIView.animateWithDuration(0.5, animations: {
            self.DocViewHeightConstraint.constant = 60
            self.view.layoutIfNeeded()
            
            }, completion: nil)
    }
    
    //MARK tableview delegate methods
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Create a table cell
        let cell = self.messageTableView.dequeueReusableCellWithIdentifier("MessageCell")! as UITableViewCell
        
        // Customize the cell
        cell.textLabel?.text = self.messageArray[indexPath.row]
        
        // Return the cell
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
