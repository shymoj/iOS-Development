//
//  Tasks.swift
//  TaskList
//
//  Created by Shyran on 3/7/18.
//  Copyright © 2018 Shyran. All rights reserved.
//

import Foundation
import os.log
class Tasks: NSObject,NSCoding{
    private var name:String
    private var check:Bool
    
    struct TaskKey{
        static let name = "name"
        static let check = "check"
    }
    
    init?(name:String, check:Int){
        self.name = name
        self.check = false
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name,forKey: TaskKey.name)
        aCoder.encode(check, forKey:TaskKey.check)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: TaskKey.name) as? String else {
            os_log("Unable to decode the name for a Task object.", log: OSLog.default, type: .debug)
            return nil
        }
        let check = aDecoder.decodeInteger(forKey: TaskKey.check)
        self.init(name:name, check:check)
    }
    
}
