//
//  EventTableViewController.swift
//  bearcatconnect
//
//  Created by Verma,Monish on 3/4/17.
//  Copyright © 2017 Verma,Monish. All rights reserved.
//

import UIKit
import Parse
import UserNotifications

class EventTableViewController: UITableViewController {
    
   
    var query:PFQuery! = nil
    var activityPost:[PFObject] = []
    var activityModel:ActivityModel!
    var selectedActivity:String = ""
    var selectedActivityTitle:String = ""
    var selectedActivityImage:UIImage! = nil
    var objectId:[String] = []
    
    @IBOutlet var eventsTV: UITableView!

    var posts:[Int] = [0]
    let titleArray = ["a","b","c"]
    var commentArray:[String] = [""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //initialize model
        activityModel = (UIApplication.shared.delegate as! AppDelegate).activityModel
        if activityModel.activity == "Cycling" {
            selectedActivity = "CyclingPost"
            self.navigationItem.title = "Cycling"
        }
        else if activityModel.activity == "Trekking" {
            selectedActivity = "TrekkingPost"
            self.navigationItem.title = "Trekking"
        }
        else if activityModel.activity == "Literature" {
            selectedActivity = "LiteraturePost"
            self.navigationItem.title = "Literature"
        }
        else if activityModel.activity == "Music" {
            selectedActivity = "MusicPost"
            self.navigationItem.title = "Music"
        }
        else if activityModel.activity == "Mathematics" {
            selectedActivity = "MathsPost"
            self.navigationItem.title = "Mathematics"
        }
        else if activityModel.activity == "Programming" {
            selectedActivity = "ProgrammingPost"
            self.navigationItem.title = "Programming"
        }
        else if activityModel.activity == "Photography" {
            selectedActivity = "PhotographyPost"
            self.navigationItem.title = "Photography"
        }
        
        query = PFQuery(className:selectedActivity)
        query.findObjectsInBackground(block: { (objects : [PFObject]?, error: Error?) -> Void in
            
            if error == nil {
                
                self.activityPost = objects!
                if let objects = objects as [PFObject]! {
                    for oneObj in objects {
                        self.objectId.append(oneObj.objectId!)
                    }
                }
                
                self.eventsTV.reloadData()
                
            } else {
                // Log details of the failure
                print("error occured")
            }
        })
        
        
        
        
        
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
        return activityPost.count
    }
    
    var count = 0

    func replyClicked(sender:UIButton) {
        
        
        print("reply button clicked \(row_number)")
        count = count + 1
        posts.append(row_number.count)
        tableView.beginUpdates()
        
        tableView.insertRows(at: [IndexPath(row: posts.count + 1, section: 0)], with: .automatic)
        
        tableView.endUpdates()
        
    }
    var notifyDate:Date! = Date()
    
    var notifyCount = 0
    func notifyClicked(sender:UIButton) {
        print("notify clicked")
        notifyCount = notifyCount + 1
        if notifyCount%2 != 0 {
            let originalDate = activityModel.notifyDate
            let calendar = Calendar.current
            let newd = calendar.date(byAdding: .hour, value: -5, to: originalDate, wrappingComponents: false)
            
            
            print("notification date here \(newd)")
            sender.setImage(#imageLiteral(resourceName: "Bell Filled-40"), for: .normal)
            let notification = UILocalNotification()
            notification.alertBody = activityModel.postTitle // text that will be displayed in the notification
            notification.alertAction = "open" // text that is displayed after "slide to..." on the lock screen - defaults to "slide to view"
            notification.fireDate = newd!  // todo item due date (when notification will be fired)
           // notification.soundName = UILocalNotificationDefaultSoundName // play default sound
           // notification.userInfo = ["title": item.title, "UUID": item.UUID] // assign a unique identifier to the notification so that we can retrieve it later
            
            UIApplication.shared.scheduleLocalNotification(notification)
        }
        else {
            sender.setImage(#imageLiteral(resourceName: "Bell-40"), for: .normal)
        }
        
        
    }
   
    
    var likeCount = 0
    
    func likeClicked(sender:UIButton) {
        
        
        
        likeCount = likeCount + 1
        
        if(likeCount%2 != 0) {
            sender.setImage(#imageLiteral(resourceName: "Like Filled-40"), for: .normal)
            
//            query.getObjectInBackground(withId: id, block: {
//                (updatedObject: PFObject?, error: Error?) -> Void in
//                if error != nil {
//                    print("error")
//                }
//                else {
//                    updatedObject?["like"] = true
//                    updatedObject?.saveInBackground()
//                }
//            })

            
            
        }
        else {
           sender.setImage(#imageLiteral(resourceName: "Like-40"), for: .normal)
//            query.getObjectInBackground(withId: id, block: {
//                (updatedObject: PFObject?, error: Error?) -> Void in
//                if error != nil {
//                    print("error")
//                }
//                else {
//                    updatedObject?["like"] = false
//                    updatedObject?.saveInBackground()
//                }
//            })

            
        
        }
        
        
        
    }
    var postcount = 1
    
    func postComment(sender:UIButton) {
        print("post comment clicked")
        print("comment array \(commentArray)")
//        postcount = postcount + 1
       
        posts.append(postcount)
        tableView.beginUpdates()
       
//        tableView.insertRows(at: [IndexPath(row: postcount - 1, section: 0)], with: .automatic)
        tableView.insertRows(at: [IndexPath(row: postcount, section: 0)], with: .automatic)
        tableView.endUpdates()
       
    }
    
    var row_number:[Int] = []
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        
        for post in activityPost {
            let post:PFObject = activityPost[(indexPath as NSIndexPath).row]
            let cell = CustomCell(frame:CGRect(x: 0, y: 0, width: self.view.frame.width, height: 100),title:"")
        
        row_number.append(indexPath.row)
        
        cell.postTitle.text = post["title"] as! String!
        activityModel.postTitle = post["title"] as! String!
        cell.postDescription.text = post["description"] as! String!
        
            //converting date object to string
            let date:Date = post["eventDate"] as! Date!
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let myString = formatter.string(from: date)
            
            let yourDate = formatter.date(from: myString)
            formatter.dateFormat = "dd-MMM-yyyy HH:mm a"
            formatter.timeZone = TimeZone.current
            activityModel.notifyDate = yourDate!
            let dateString = formatter.string(from: yourDate!)
       
            
        cell.eventTime.text = dateString
       
        
        
        cell.likeButton.addTarget(self, action:#selector(likeClicked(sender:)), for: .touchUpInside)
       // cell.replyButton.addTarget(self, action: #selector(replyClicked(sender:)), for: .touchUpInside)
        cell.notifyButton.addTarget(self, action: #selector(notifyClicked(sender:)), for: .touchUpInside)
            
        return cell
        }
       /*
        else if(indexPath.row == 1) {
            let cell = CommentCell(frame:CGRect(x: 0, y: 0, width: self.view.frame.width, height: 100),title:"")
            cell.commentText.text = commentArray[indexPath.row-1]
            return cell
        }
 */
       
        
            let cell = PostCommentCell(frame:CGRect(x: 0, y: 0, width: self.view.frame.width, height: 100),title:"")
            commentArray.append(cell.commentText.text!)
            print("comment array inside cell \(commentArray)")
            cell.postCommentButton.addTarget(self, action: #selector(postComment(sender:)), for: .touchUpInside)
            return cell
        
 
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100;//Choose your custom row height
    }
    
    
    //custom cell programmatically
    class CustomCell: UITableViewCell {
        
        var postTitle: UILabel!
        var postDescription: UILabel!
        var eventTime: UILabel!
        var notifyButton: UIButton!
        var likeButton: UIButton!
        var replyButton: UIButton!
        
        
        init(frame: CGRect, title: String) {
            super.init(style: UITableViewCellStyle.default, reuseIdentifier: "eventView")
            
            
            //post title label
            postTitle = UILabel(frame: CGRect(x: 80 ,y: 10,width: 150 ,height: 20))
            postTitle.textColor = UIColor.blue
            
            //event description
            postDescription = UILabel(frame: CGRect(x: 80 ,y: 40,width: 200 ,height: 20))
            postDescription.textColor = UIColor.black
            
            //event time label
            eventTime = UILabel(frame: CGRect(x: 80 ,y: 70,width: 200 ,height: 20))
            eventTime.textColor = UIColor.black
            
            //notify button
            notifyButton = UIButton(frame: CGRect(x: 5, y: 50, width: 50, height: 50))
            notifyButton.setImage(#imageLiteral(resourceName: "Bell-40"), for: .normal)
            
            //like button
            likeButton = UIButton(frame: CGRect(x: 300, y: 5, width: 50, height: 50))
            likeButton.setImage(#imageLiteral(resourceName: "Like-40"), for: .normal)
            
            //reply button
            replyButton = UIButton(frame: CGRect(x: 300, y: 50, width: 50, height: 50))
            replyButton.setImage(#imageLiteral(resourceName: "Reply Arrow-40"), for: .normal)
            
            //adding to subview
           
            
            addSubview(postTitle)
            addSubview(postDescription)
            addSubview(eventTime)
            addSubview(notifyButton)
            addSubview(likeButton)
            addSubview(replyButton)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
        }
    }
    
    class CommentCell: UITableViewCell {
        
        var commentText: UILabel!
        
        
        
        
        init(frame: CGRect, title: String) {
            super.init(style: UITableViewCellStyle.default, reuseIdentifier: "commentView")
            
           
            //post count label
            commentText = UILabel(frame: CGRect(x: 10,y: 10,width: 320 ,height: 80))
            commentText.layer.borderWidth = 2
            commentText.layer.borderColor = UIColor.black.cgColor
            
            //adding to subview
            
            addSubview(commentText)
            
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
        }
    }
    
    class PostCommentCell: UITableViewCell {
        
        var commentText: UITextField!
        var postCommentButton: UIButton!
        
        
        
        init(frame: CGRect, title: String) {
            super.init(style: UITableViewCellStyle.default, reuseIdentifier: "postCommentView")
            
            //post count label
            commentText = UITextField(frame: CGRect(x: 10,y: 10,width: 280 ,height: 80))
            commentText.layer.borderWidth = 2
            commentText.layer.borderColor = UIColor.black.cgColor
            
            postCommentButton = UIButton(frame: CGRect(x: 300, y: 40, width: 50, height: 50))
            postCommentButton.setTitle("Post", for: .normal)
            postCommentButton.setTitleColor(UIColor.black, for: .normal)
            //adding to subview
            
            addSubview(commentText)
            addSubview(postCommentButton)
            
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
        }
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
