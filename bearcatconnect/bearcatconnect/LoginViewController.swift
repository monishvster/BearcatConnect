//
//  ViewController.swift
//  bearcatconnect
//
//  Created by Verma,Monish on 2/27/17.
//  Copyright © 2017 Verma,Monish. All rights reserved.
//
import Parse
import UIKit

class LoginViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
               // Do any additional setup after loading the view, typically from a nib.
    }
    @IBOutlet weak var usernameTXT: UITextField!
    @IBOutlet weak var passwordTXT: UITextField!
    
    
    
    @IBAction func signIN(_ sender: Any) {
        
        let username = usernameTXT.text
        let password = passwordTXT.text
        
        
        PFUser.logInWithUsername(inBackground: username!, password: password!, block: {(user, error) -> Void in
            if error != nil{
               
                let refreshAlert = UIAlertController(title: "Error  ", message: "Username/Password is incorrect", preferredStyle: UIAlertControllerStyle.alert)
                refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                    self.usernameTXT.text = ""
                    self.passwordTXT.text = ""
                }))
                self.present(refreshAlert, animated: true, completion: nil)
            }
            else {
                // Everything went alright here
                self.performSegue(withIdentifier: "activitySegue", sender: self)
                
                
            }
        })

    }
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

