//
//  ViewController.swift
//  bearcatconnect
//
//  Created by Verma,Monish on 2/27/17.
//  Copyright © 2017 Verma,Monish. All rights reserved.
//
import Parse
import UIKit

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let testObject = PFObject(className: "TestObject")
        testObject["foo"] = "bar"
        testObject.saveInBackground { (success: Bool, error: Error?) -> Void in
            print("Object has been saved.")
        }

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

