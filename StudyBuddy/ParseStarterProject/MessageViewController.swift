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
    
    var receiverId = ""
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
        /*self.messageArray.append("Test 1")
        self.messageArray.append("Test 2")
        self.messageArray.append("Test 3")**/
        
        //Retreive messages from Parse
        self.retrieveMessages()
        
        
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
        /*
        var name = ""
        //set text to the text of the message field and save PFObject
        var query:PFQuery = PFQuery(className: "User")
        query.findObjectsInBackgroundWithBlock{(results, error) -> Void in
            for object in results! {
                if object["objectId"] as! String == PFUser.currentUser()!.objectId! {
                    name = object["name"]
                }
                
            }
        }**/
        
        
        newMessageObject.setObject(self.MessageTextField.text!, forKey: "Text")
        newMessageObject.setObject(PFUser.currentUser()!.objectId!, forKey: "sender")
        newMessageObject.setObject(receiverId, forKey: "receiver")
        newMessageObject.saveInBackgroundWithBlock(
            {
                (succeeded:Bool, error:NSError?) -> Void in
                if succeeded {
                    NSLog("Object created with id: (newMessageObject.objectId)")
                } else {
                    NSLog(error!.description)
                }
                
                dispatch_async(dispatch_get_main_queue()) {
                    self.SendButton.enabled = true
                    self.MessageTextField.enabled = true
                    self.MessageTextField.text = ""
                }
            }
        )
        
        self.retrieveMessages()
    }
    
    func retrieveMessages() {
        // Create a new PFQuery
        var query:PFQuery = PFQuery(className: "Messages")

        // Call findobjectsinBackground
        query.findObjectsInBackgroundWithBlock { (results, error) -> Void in
            // Clear the messagesArray
            self.messageArray = [String]()
            
            // Loop through the objects array
            for messageObject in results! {
                let curr = messageObject as! PFObject
                if(curr["sender"] as! String == PFUser.currentUser()!.objectId! && curr["receiver"] as! String == self.receiverId) {
                // Retreive the Text column value of each PFObject
                    let messageText:String? = (messageObject as! PFObject)["Text"] as? String
                
                    // Assign it into our messagesArray
                    if messageText != nil {
                    self.messageArray.append(messageText!)
                    }
                }
            }
            
            dispatch_async(dispatch_get_main_queue()) {
                // Reload the tableView
                self.messageTableView.reloadData()
            }
        }
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
        self.retrieveMessages()
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        self.view.layoutIfNeeded()
        UIView.animateWithDuration(0.5, animations: {
            self.DocViewHeightConstraint.constant = 60
            self.view.layoutIfNeeded()
            
            }, completion: nil)
        self.retrieveMessages()
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
