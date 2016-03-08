//
//  MessageViewController.swift
//  ParseStarterProject
//
//  Created by Eric Tran on 3/6/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBAction func showSwipeScreen(sender: AnyObject) {
        self.performSegueWithIdentifier("showSwipeScreen", sender: self)
    }

    @IBOutlet weak var messageTableView: UITableView!
    var messageArray:[String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.messageTableView.delegate = self
        self.messageTableView.dataSource = self
        
        //Add some sample data so we can see something
        self.messageArray.append("Test 1")
        self.messageArray.append("Test 2")
        self.messageArray.append("Test 3")
        
    }

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
