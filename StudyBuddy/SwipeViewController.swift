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
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var majorLabel: UILabel!
    
    var displayUserId = ""
    var myClassList = [String]()
    var matchClassList = [String]()
    
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
                
                PFUser.currentUser()?.saveInBackground()
                
            }
            
            
            
            rotation = CGAffineTransformMakeRotation(0)
            
            stretch = CGAffineTransformScale(rotation, 1, 1)
            
            label.transform = stretch
            
            label.center = CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height / 2)
            
            updateImage()
            
        }
        self.userImage.image = UIImage(named: "bad-report-card")
        self.nameLabel.text = ""
        self.majorLabel.text = ""
    }

    
    func updateImage() {
        
        var query = PFUser.query()!
        
        //query.whereKey("location", withinGeoBoxFromSouthwest: PFGeoPoint(latitude: 0, longitude: 0)
        
        var interestedIn = "male"
        
        
//        if PFUser.currentUser()!["interestedInGirl"]! as! Bool == true {
//            
//            interestedIn = "female"
//            
//        }
//        
//        var isFemale = true
//        
//        if PFUser.currentUser()!["gender"]! as! String == "male" {
//            isFemale = false
//        }
        
        
        //if let acceptedUsers =
        
//        query.whereKey("gender", equalTo: interestedIn)
//        query.whereKey("interestedInGirl", equalTo: isFemale)
        //query.whereKey("major", equalTo: "Computer Science")
        
        
//        if PFUser.currentUser()!["classes"]  != nil {
//            myClassList = PFUser.currentUser()!["classes"] as! [String]
//            print(myClassList)
//        }
        
        if let latitude = PFUser.currentUser()?["location"]?.latitude {
            if let longitude = PFUser.currentUser()?["location"]?.longitude {
                
                query.whereKey("location", withinGeoBoxFromSouthwest: PFGeoPoint(latitude: latitude - 1, longitude: longitude - 1),
                               toNortheast: PFGeoPoint(latitude: latitude + 1, longitude: longitude + 1))
                
            }
        }
        
        
        
        //Selection for course matching condition
        query.whereKey("classes", containedIn: myClassList)
        
        //query.whereKey("classes", containsString: "CPE123")
        //query.whereKey("objectId", containedIn: PFUser.currentUser()?["accepted"] as! [String])
        
        var ignoredUsers = [""]
        
        if let acceptedUsers = PFUser.currentUser()?["accepted"] {
            
            ignoredUsers += acceptedUsers as! Array
            
            
        }
        
        if let rejecteddUsers = PFUser.currentUser()?["rejected"] {
            
            ignoredUsers += rejecteddUsers as! Array
        }
        
        query.whereKey("objectId", notContainedIn: ignoredUsers)
    
        //take out yourself when swiping
        query.whereKey("objectId", notEqualTo: (PFUser.currentUser()?.objectId)!)
        
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
                            else {
                                self.userImage.image = UIImage(named: "bad-report-card")
                            }
                            
                        }
                    }
                    
                    let usersName = object["name"] as! String
                    let usersMajor = object["major"] as! String
                    
                    self.nameLabel.text = usersName
                    self.majorLabel.text = usersMajor
                    
                    self.matchClassList = object["classes"] as! [String]
                    print(self.matchClassList)
                    
                }
            }
            
        }

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let logo = UIImage(named: "NavBarCrammer.jpg")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        
        
        navigationController!.navigationBar.barTintColor = UIColor(red: 77/255, green: 161/255, blue: 169/255, alpha: 1.0)
        //navigationController?.navigationBar.barTintColor = UIColor.blueColor()
        self.view.backgroundColor = UIColor(red: 242/255, green: 236/255, blue: 179/255, alpha: 1.0)
        
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
        
        if (PFUser.currentUser()?.objectForKey("classes") != nil) {
            print("Here Here Here")
            myClassList = PFUser.currentUser()?.objectForKey("classes") as! [String]
            print(myClassList)
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
