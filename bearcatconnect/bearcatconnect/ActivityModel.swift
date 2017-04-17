//
//  ActivityModel.swift
//  bearcatconnect
//
//  Created by Verma,Monish on 4/16/17.
//  Copyright © 2017 Verma,Monish. All rights reserved.
//

import Foundation

class ActivityModel {
    
    var notifyDate:Date
    var activity:String
    var postTitle:String
    
    init(activity:String,notifyDate:Date,postTitle:String) {
        self.activity = activity
        self.notifyDate = notifyDate
        self.postTitle = postTitle
    }
}
