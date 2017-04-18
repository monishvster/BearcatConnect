//
//  CyclingViewController.swift
//  bearcatconnect
//
//  Created by Verma,Monish on 3/6/17.
//  Copyright © 2017 Verma,Monish. All rights reserved.
//

import UIKit
import Parse


class CreatePostController: UIViewController, UITextFieldDelegate {
    
    var createPost:PFObject! = nil
    var activityModel:ActivityModel!
    var selectedActivity:String = ""
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleTXT.delegate = self
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CreatePostController.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
        
        
        activityModel = (UIApplication.shared.delegate as! AppDelegate).activityModel
        
        print("selected row here \(activityModel.activity)")
        if activityModel.activity == "Cycling" {
            selectedActivity = "CyclingPost"
        }
        else if activityModel.activity == "Trekking" {
            selectedActivity = "TrekkingPost"
        }
        else if activityModel.activity == "Literature" {
            selectedActivity = "LiteraturePost"
        }
        else if activityModel.activity == "Music" {
            selectedActivity = "MusicPost"
        }
        else if activityModel.activity == "Mathematics" {
            selectedActivity = "MathsPost"
        }
        else if activityModel.activity == "Programming" {
            selectedActivity = "ProgrammingPost"
        }
        else if activityModel.activity == "Photography" {
            selectedActivity = "PhotographyPost"
        }
        
        createPost = PFObject(className: selectedActivity)
        
       // self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(CyclingViewController.dismiss as (CyclingViewController) -> () -> ()))
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var titleTXT: UITextField!

    @IBOutlet weak var descriptionTXT: UITextView!
    
    

    @IBAction func createPost(_ sender: UIButton) {
        
       
        
        if(titleTXT.text == "" || descriptionTXT.text == "") {
            let refreshAlert = UIAlertController(title: "Error  ", message: "Title/Description is missing", preferredStyle: UIAlertControllerStyle.alert)
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
               
            }))
            self.present(refreshAlert, animated: true, completion: nil)
        }
        else {
            
       
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
            print("error occured")
                
            }
            else {
                let refreshAlert = UIAlertController(title: "Success", message: "Event Created Successfully", preferredStyle: UIAlertControllerStyle.alert)
                refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                    self.titleTXT.text = ""
                    self.descriptionTXT.text = ""
                    self.datePicker.setDate(NSDate.init() as Date, animated: true)
                }))
                self.present(refreshAlert, animated: true, completion: nil)
                        }
            })
        }
        
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
