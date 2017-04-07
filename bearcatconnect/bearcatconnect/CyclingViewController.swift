//
//  CyclingViewController.swift
//  bearcatconnect
//
//  Created by Verma,Monish on 3/6/17.
//  Copyright © 2017 Verma,Monish. All rights reserved.
//

import UIKit
import Parse


class CyclingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       // self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(CyclingViewController.dismiss as (CyclingViewController) -> () -> ()))
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var titleTXT: UITextField!

    @IBOutlet weak var descriptionTXT: UITextView!
    
    
    @IBAction func createPost(_ sender: UIButton) {
        let createPost = PFObject(className: "CyclingPost")
        createPost["sid"] = 1
        createPost["title"] = titleTXT.text!
                createPost["eventDate"] = datePicker.date
        let date = datePicker.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd hh:mm a"
        let dateString = dateFormatter.string(from: date)
        print("checking date \(dateString)")
        
        
        createPost["eventDate"] = date
        createPost["description"] = descriptionTXT.text
        
        createPost.saveInBackground(block: {(user, error) -> Void in
            if error != nil{
            print("success")
            }
            else {
            print(error)
            }
            })
        
    }
    
    // MARK: - Navigation

    
    /*
     
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
