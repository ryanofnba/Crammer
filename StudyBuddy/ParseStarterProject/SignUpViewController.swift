//
//  SignUpViewController.swift
//  ParseStarterProject
//
//  Created by Ryan Huang on 2/25/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var interestedInGirl: UISwitch!
    
    
    @IBAction func signUp(sender: AnyObject) {
        
        PFUser.currentUser()?["interestedInGirl"] = interestedInGirl.on
        PFUser.currentUser()?.save()
        self.performSegueWithIdentifier("showSwipeScreen", sender: self)
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Test Users
        /*let urlArrayGirls = ["https://scontent.fsjc1-2.fna.fbcdn.net/hphotos-ash2/v/t1.0-9/10384350_346033485571205_5522679466824224153_n.jpg?oh=be47fda99d894bad7b1965876c580f9f&oe=5762D769",
                        "https://scontent.fsjc1-2.fna.fbcdn.net/hphotos-xtp1/v/t1.0-9/12074959_10206043798712399_3380198575925993927_n.jpg?oh=59a8c419506dcd41ead78f03a60e2e9b&oe=576ED11B",
                        "https://scontent.fsjc1-2.fna.fbcdn.net/hphotos-xft1/v/t1.0-9/11109279_10206672269755798_5774940047570643331_n.jpg?oh=fd44d4499ba6f21cc9e58b2663cf4507&oe=57567D0F"]
        
        let urlArrayGuys = [
                             "https://scontent.fsjc1-2.fna.fbcdn.net/hphotos-xpt1/v/t1.0-9/12193461_968787716519549_6464370550512200953_n.jpg?oh=0dc8889c3405eede3dd3583ada8120a1&oe=575B7694",
                             "https://scontent.fsjc1-2.fna.fbcdn.net/hphotos-ash2/v/t1.0-9/579654_10151762778824123_1497649301_n.jpg?oh=a81a3fa93222363755e049c164b7c6f6&oe=572417C4",
                             ]
        
        var count = 1
        
        for url in urlArrayGirls {
            
            let nsUrl = NSURL(string: url)
            
            
            
            if let data = NSData(contentsOfURL: nsUrl!) {
                    
                self.userImage.image = UIImage(data: data)
                    
                let imageFile:PFFile = PFFile(data: data)
                    
                let user:PFUser = PFUser()
                
                var username = "user\(count)"
                
                user.username = username
                user.password = "pass"
                user["image"] = imageFile
                user["interestedInGirl"] = false
                user["gender"] = "female"
                
                count++
                user.signUp()
            }
        }
        
        for url in urlArrayGuys {
            
            let nsUrl = NSURL(string: url)
                
                
                
            if let data = NSData(contentsOfURL: nsUrl!) {
                    
                self.userImage.image = UIImage(data: data)
                    
                let imageFile:PFFile = PFFile(data: data)
                    
                let user:PFUser = PFUser()
                
                var username = "user\(count)"
                
                user.username = username
                user.password = "pass"
                user["image"] = imageFile
                user["interestedInGirl"] = true
                user["gender"] = "male"
                
                count++
                user.signUp()
            }
        }*/
        
        

        // Do any additional setup after loading the view.
        let graphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, gender"])
        graphRequest.startWithCompletionHandler({
            
            
            (connection, result, error) -> Void in
            
            if error != nil {
                print(error)
            } else if let result = result {
                print(result)
                PFUser.currentUser()?["gender"] = result["gender"]
                PFUser.currentUser()?["name"] = result["name"]
                
                PFUser.currentUser()?.save()
                
                let userId = result["id"] as! String
                let facebookProfilePictureURL = "https://graph.facebook.com/" + userId + "/picture?type=large"
                
                if let fbpicURL = NSURL(string: facebookProfilePictureURL) {
                    
                    if let data = NSData(contentsOfURL: fbpicURL) {
                        
                        self.userImage.image = UIImage(data: data)
                        
                        let imageFile:PFFile = PFFile(data: data)
                        
                        PFUser.currentUser()?["image"] = imageFile
                        PFUser.currentUser()?.save()
                        
                    }
                    
                }
            }
        })
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
