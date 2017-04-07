//
//  EventTableViewController.swift
//  bearcatconnect
//
//  Created by Verma,Monish on 3/4/17.
//  Copyright © 2017 Verma,Monish. All rights reserved.
//

import UIKit

class EventTableViewController: UITableViewController {
    
   // var eventCount:[Int]!
    @IBOutlet var eventsTV: UITableView!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // eventCount = [1,2]

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        return 2
    }
    var commentText = ["a","b","c"]

    func replyClicked(sender:UIButton) {
        
        let buttonRow = sender.tag
        print("reply button clicked \(buttonRow)")
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: commentText.count-1, section: 0)], with: .automatic)
        tableView.endUpdates()
        
    }
    
    func likeClicked(sender:UIButton) {
        
        let buttonRow = sender.tag
        print("button clicked \(buttonRow)")
        sender.setImage(#imageLiteral(resourceName: "Like Filled-40"), for: UIControlState.normal)
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "eventView", for: indexPath) as! eventTableViewCell
        cell.likeBTN.tag = indexPath.row
        
        cell.likeBTN.addTarget(self,action:#selector(likeClicked(sender:)), for: .touchUpInside)
        
        
        cell.replyBTN.addTarget(self, action: #selector(replyClicked(sender:)), for: .touchUpInside)
        
        
    
        
       // countLBL.text? = String(eventCount[indexPath.row])
       // eventNameLBL.text? = "20 mile trail"
      //  eventDateLBL.text? = "20th, Feb"
      //  eventTimeLBL.text? = "10:00 AM"
        
        

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100.0;//Choose your custom row height
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
