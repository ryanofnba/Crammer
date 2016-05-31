//
//  ClassManager.swift
//  ParseStarterProject
//
//  Created by Kevin Pham on 5/27/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

var classMgr: ClassManager = ClassManager()

struct task {
    var name = "Name"
    var desc = "Description"
}

class ClassManager: NSObject {
    var tasks = [task]()
    
    override init() {
        print("HI")
        //Create an empty array
        var myArray: [String] = [String]()
        
        //Get the data from the PFQuery class
       /* let query = PFUser.query()
        query!.findObjectsInBackgroundWithBlock{
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                //if let objects = objects as? [PFObject] {
                    for object in objects! {
                        
                        //For each object in the class object, append it to myArray
                        myArray.append(object["name"])
                        print("adding")
                    }
                    
                //}
            } else {
                print("\(error?.userInfo)")
            }
        }*/
        var classes = []
        if (PFUser.currentUser()?.objectForKey("classes") != nil) {
        classes = PFUser.currentUser()?.objectForKey("classes") as! [String]
        for object in classes {
            
            //For each object in the class object, append it to myArray
            myArray.append(object as! String)
            //print("adding")
        }
        print(myArray.count)
        for i in 0 ..< myArray.count {
            print(myArray[i])
            let index = myArray[i].startIndex.advancedBy(3)
            let subject = myArray[i].substringToIndex(index)
            let classNum = myArray[i].substringFromIndex(index)
            tasks.append(task(name: subject, desc: classNum))
        }
        }
    }
    
    func addTask(name: String, desc: String) {
        tasks.append(task(name: name, desc: desc))
    }
    
    func getClasses() -> [String] {
        var classes: [String] = []
        for i in 0 ..< tasks.count {
           classes.append(tasks[i].name + tasks[i].desc)
        }
        //classes.append("CPE123")
        return classes
    }
}
