//
//  SwipeViewController.swift
//  ParseStarterProject
//
//  Created by Ryan Huang on 2/25/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class SwipeViewController: UIViewController {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var infoLabel: UILabel!
    
    var displayUserId = ""
    
    @IBAction func onClickMessages(sender: AnyObject) {
         self.performSegueWithIdentifier("showMessages", sender: self)
    }
    
    @IBAction func onClickSettings(sender: AnyObject) {
        self.performSegueWithIdentifier("showMainSettings", sender: self)
    }
    /**@IBAction func onClickSetting(sender: AnyObject) {
        self.performSegueWithIdentifier("showMainSettings", sender: self)
    }*/

    
    func wasDragged(gesture: UIPanGestureRecognizer) {
        
        let translation = gesture.translationInView(self.view)
        let label = gesture.view!
        
        label.center = CGPoint(x: self.view.bounds.width / 2 + translation.x, y: self.view.bounds.height / 2 + translation.y)
        
        let xFromCenter = label.center.x - self.view.bounds.width / 2
        
        let scale = min(100 / abs(xFromCenter), 1)
        
        
        var rotation = CGAffineTransformMakeRotation(xFromCenter / 200)
        
        var stretch = CGAffineTransformScale(rotation, scale, scale)
        
        label.transform = stretch
        
        
        if gesture.state == UIGestureRecognizerState.Ended {
            
            var acceptedOrRejected = ""
            
            if label.center.x < 100 {
                
                //print("Not chosen" + displayUderId)
                acceptedOrRejected = "rejected"
                
            } else if label.center.x > self.view.bounds.width - 100 {
                
                //print("Chosen")
                acceptedOrRejected = "accepted"
            }
            
            if acceptedOrRejected != "" {
                
                PFUser.currentUser()?.addUniqueObjectsFromArray([displayUserId], forKey:acceptedOrRejected)
                
                PFUser.currentUser()?.save()
                
            }
            
            
            
            rotation = CGAffineTransformMakeRotation(0)
            
            stretch = CGAffineTransformScale(rotation, 1, 1)
            
            label.transform = stretch
            
            label.center = CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height / 2)
            
            updateImage()
            
        }
    }

    
    func updateImage() {
        
        var query = PFUser.query()!
        
        //query.whereKey("location", withinGeoBoxFromSouthwest: PFGeoPoint(latitude: 0, longitude: 0)
        
        var interestedIn = "male"
        
        
        if PFUser.currentUser()!["interestedInGirl"]! as! Bool == true {
            
            interestedIn = "female"
            
        }
        
        var isFemale = true
        
        if PFUser.currentUser()!["gender"]! as! String == "male" {
            isFemale = false
        }
        
        
        //if let acceptedUsers =
        
        query.whereKey("gender", equalTo: interestedIn)
        query.whereKey("interestedInGirl", equalTo: isFemale)
        
        var ignoredUsers = [""]
        
        if let acceptedUsers = PFUser.currentUser()?["accepted"] {
            
            ignoredUsers += acceptedUsers as! Array
            
            
        }
        
        if let rejecteddUsers = PFUser.currentUser()?["rejected"] {
            
            ignoredUsers += rejecteddUsers as! Array
        }
        
        query.whereKey("objectId", notContainedIn: ignoredUsers)
        
        
        
        query.limit = 1
        
        
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error != nil {
                print(error)
            } else if let objects = objects as? [PFObject] {
                for object in objects {
                    
                    self.displayUserId = object.objectId!
                    
                    let imageFile = object["image"] as! PFFile
                    
                    imageFile.getDataInBackgroundWithBlock {
                        (imageData: NSData?, error: NSError?) -> Void in
                        
                        if error != nil {
                            print(error)
                        } else {
                            
                            if let data = imageData {
                                
                                self.userImage.image = UIImage(data: data)
                                
                            }
                            
                        }
                    }
                    
                }
            }
            
        }

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let logo = UIImage(named: "NavBarCrammer.jpg")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        
        //swiping
        let gesture = UIPanGestureRecognizer(target: self, action: Selector("wasDragged:"))
        userImage.addGestureRecognizer(gesture)
        userImage.userInteractionEnabled = true
        
        
        
        PFGeoPoint.geoPointForCurrentLocationInBackground {
            
            (geoPoint: PFGeoPoint?, error: NSError?) -> Void in
            
            if let geoPoint = geoPoint {
                PFUser.currentUser()?["location"] = geoPoint
                PFUser.currentUser()?.saveInBackground()
            }
        }
        
        
        updateImage()
        
        
        
        
        

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "logOut" {
            PFUser.logOut()
        }
        
    }
    

}
