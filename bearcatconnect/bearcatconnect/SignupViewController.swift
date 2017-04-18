//
//  SignupViewController.swift
//  bearcatconnect
//
//  Created by Verma,Monish on 3/24/17.
//  Copyright © 2017 Verma,Monish. All rights reserved.
//

import UIKit
import Parse
import Bolts

class SignupViewController: UIViewController,UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.username.delegate = self
        self.firstname.delegate = self
        self.lastname.delegate = self
        self.password.delegate = self
        self.confirm.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var firstname: UITextField!
    @IBOutlet weak var lastname: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirm: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
   
    @IBAction func signUp(_ sender: Any) {
        let fname = firstname.text
        let lname = lastname.text
        let user = PFUser()
        user.username = username.text
        if confirm.text == password.text {
        user.password = confirm.text
            
            user.setValue(fname, forKey: "fname")
            user.setValue(lname, forKey: "lname")
            
            if username.text == "" || fname == "" || lname == "" || password.text == "" || confirm.text == "" {
                let refreshAlert = UIAlertController(title: "Error  ", message: "Please enter the fields", preferredStyle: UIAlertControllerStyle.alert)
                refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                    
                }))
                self.present(refreshAlert, animated: true, completion: nil)
            }
            else {
            
            
            
            user.signUpInBackground(block: { (success, error) -> Void in
            })
            
            errorLabel.text = ""
            self.dismiss(animated: true, completion: {})
            }
        }
        else {
            errorLabel.text = "Passwords do not match"
            errorLabel.textColor = UIColor.red
            confirm.text = ""
            password.text = ""
        }
        
        
        
    }
    

    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true, completion: {})
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
