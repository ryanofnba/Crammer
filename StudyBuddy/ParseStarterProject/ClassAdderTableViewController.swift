//
//  ClassAdderTableViewController.swift
//  ParseStarterProject
//
//  Created by Michelle Wong on 5/20/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class ClassAdderTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tblTasks : UITableView!
    
    @IBAction func SaveClassList(sender: AnyObject) {
        PFUser.currentUser()?["classes"] = classMgr.getClasses()
        //PFUser.currentUser()?["classes"] = []
        PFUser.currentUser()?.save()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let logo = UIImage(named: "NavBarCrammer.jpg")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        
        tblTasks.reloadData()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        tblTasks.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return classMgr.tasks.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Default Tasks")
        
        cell.textLabel?.text = classMgr.tasks[indexPath.row].name + classMgr.tasks[indexPath.row].desc
        //cell.detailTextLabel?.text = classMgr.tasks[indexPath.row].desc
        
        return cell
    }

    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
        if (editingStyle == UITableViewCellEditingStyle.Delete){
            
            classMgr.tasks.removeAtIndex(indexPath.row)
            tblTasks.reloadData()
        }
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
