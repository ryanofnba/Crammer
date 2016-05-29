//
//  ClassManager.swift
//  ParseStarterProject
//
//  Created by Kevin Pham on 5/27/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit

var classMgr: ClassManager = ClassManager()

struct task {
    var name = "Name"
    var desc = "Description"
}

class ClassManager: NSObject {
    var tasks = [task]()
    
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
