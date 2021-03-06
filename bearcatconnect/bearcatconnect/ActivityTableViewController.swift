//
//  ActivityTableViewController.swift
//  bearcatconnect
//
//  Created by Verma,Monish on 3/1/17.
//  Copyright © 2017 Verma,Monish. All rights reserved.
//

import UIKit
import Parse
import Bolts

class ActivityTableViewController: UITableViewController {

    var activityName:[String]!
    var activityImages:[UIImage]!
    var activityModel:ActivityModel!
    
    
    @IBOutlet var activityView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //initialize model
        activityModel = (UIApplication.shared.delegate as! AppDelegate).activityModel
        
        activityView.delegate = self
        activityView.dataSource = self
        activityName = ["Cycling","Trekking","Literature","Music","Mathematics","Programming","Photography"]
        activityImages = [#imageLiteral(resourceName: "Cycling"),#imageLiteral(resourceName: "Trekking"),#imageLiteral(resourceName: "Literature"),#imageLiteral(resourceName: "Music"),#imageLiteral(resourceName: "Mathematics"),#imageLiteral(resourceName: "Code"),#imageLiteral(resourceName: "Camera")]
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (PFUser.current() == nil) {
            DispatchQueue.main.async(execute: {
                print("async")
                let loginViewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "loginView")
                self.present(loginViewController, animated: true, completion: nil)
                
            })
                    }
        else{
            print("logged in")
        }
    }

    @IBAction func logout(_ sender: Any) {
        PFUser.logOut()
        let login = storyboard?.instantiateViewController(withIdentifier: "loginView")
        self.present(login!, animated: true, completion: {})
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return activityName.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "interestCell", for: indexPath)

        cell.textLabel?.text = activityName[indexPath.row]
        cell.imageView?.image = activityImages[indexPath.row]
        

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedRow = activityName[indexPath.row]
        activityModel.activity = selectedRow
        
        
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
