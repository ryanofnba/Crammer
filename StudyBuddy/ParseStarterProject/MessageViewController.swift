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
        navigationController!.navigationBar.barTintColor = UIColor(red: 77/255, green: 161/255, blue: 169/255, alpha: 1.0)
        //navigationController?.navigationBar.barTintColor = UIColor.blueColor()
        self.messageTableView.backgroundColor = UIColor(red: 242/255, green: 236/255, blue: 179/255, alpha: 1.0)
        

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
        
        //Retreive messages from Parse
        self.retrieveMessages()
        
        
        navigationController!.navigationBar.barTintColor = UIColor(red: 77/255, green: 161/255, blue: 169/255, alpha: 1.0)
        //navigationController?.navigationBar.barTintColor = UIColor.blueColor()
        self.view.backgroundColor = UIColor(red: 242/255, green: 236/255, blue: 179/255, alpha: 1.0)
        
    }
    @IBAction func SendButtonTapped(sender: UIButton) {
        //send button is tapped
        //call end editing method
        self.retrieveMessages()
        self.MessageTextField.endEditing(true)
        
        //create PFObject
        var newMessageObject = PFObject(className:"Messages")
        
        let currentUser = PFUser.currentUser()
        
        let nameText = currentUser!["name"] as! String
        var fullName = nameText.characters.split{$0 == " "}.map(String.init)

        print (nameText)
        
        newMessageObject.setObject(fullName[0] + ": " + self.MessageTextField.text!, forKey: "Text")
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
                if((curr["sender"] as! String == PFUser.currentUser()!.objectId! && curr["receiver"] as! String == self.receiverId) || (curr["sender"] as! String == self.receiverId && curr["receiver"] as! String == PFUser.currentUser()!.objectId!)) {
                //if((curr["sender"] as! String == PFUser.currentUser()!.objectId! && curr["receiver"] as! String == self.receiverId) ) {
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
        self.retrieveMessages()
        self.MessageTextField.endEditing(true)
    }
    
    //MARK textField delegate methods
    func textFieldDidBeginEditing(textField: UITextField) {
        self.retrieveMessages()
        self.view.layoutIfNeeded()
        UIView.animateWithDuration(0.5, animations: {
            self.DocViewHeightConstraint.constant = 350
            self.view.layoutIfNeeded()
            
            }, completion: nil)
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        self.retrieveMessages()
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
        
        cell.backgroundColor = UIColor(red: 242/255, green: 236/255, blue: 179/255, alpha: 1.0)
        // Customize the cell
        cell.textLabel?.text = self.messageArray[indexPath.row]
        
        // Name registers with the name
        
        let message = cell.textLabel?.text as String!
        var split = message.characters.split{$0 == " "}.map(String.init)
        let name = split[0].substringToIndex(split[0].endIndex.predecessor())
        
        // current user's name
        let currName = PFUser.currentUser()!["name"] as! String
        var currArr = currName.characters.split{$0 == " "}.map(String.init)
        let currFirstName = currArr[0]
        
        // compare, if its equal, means the user's messages should be shifted right
        if (name == currFirstName) {
            cell.textLabel?.textAlignment = NSTextAlignment.Right
        }
        // Return the cell
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }

}
