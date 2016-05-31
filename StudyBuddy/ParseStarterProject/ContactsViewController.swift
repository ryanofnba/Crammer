//
//  ContactsViewController.swift
//  ParseStarterProject
//
//  Created by Ryan Huang on 5/31/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class ContactsViewController: UITableViewController {
    
    var usernames = [String]()
    var images = [UIImage]()
    
    
    @IBAction func backButton(sender: AnyObject) {
        self.performSegueWithIdentifier("showSwipeScreen", sender: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var query = PFUser.query()!
        query.whereKey("accepted", equalTo: PFUser.currentUser()!.objectId!)
        query.whereKey("objectId", containedIn: PFUser.currentUser()?["accepted"] as! [String])
        
        query.findObjectsInBackgroundWithBlock { (results, error) -> Void in
            if let results = results {
                
                for result in results as! [PFUser] {
                    self.usernames.append(result.username!)
                    
                    let imageFile = result["image"] as! PFFile
                    
                    imageFile.getDataInBackgroundWithBlock {
                        (imageData: NSData?, error: NSError?) -> Void in
                        
                        if error != nil {
                            print(error)
                        } else {
                            
                            if let data = imageData {
                                
                                self.images.append(UIImage(data: data)!)
                                self.tableView.reloadData()
                                
                            }
                            
                        }
                    }

                }
                print(results)
            }
            
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return usernames.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)

        cell.textLabel!.text = usernames[indexPath.row]
        
        if images.count > indexPath.row {
            cell.imageView?.image = images[indexPath.row]
        }
        
        return cell
    }
    

}
