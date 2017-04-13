//
//  EventTableViewController.swift
//  bearcatconnect
//
//  Created by Verma,Monish on 3/4/17.
//  Copyright © 2017 Verma,Monish. All rights reserved.
//

import UIKit
import Parse

class EventTableViewController: UITableViewController {
    
   // var eventCount:[Int]!
    var cyclePost:[PFObject] = []
    
    
    @IBOutlet var eventsTV: UITableView!

    var posts:[Int] = [0]
    let titleArray = ["a","b","c"]
    var commentArray:[String] = [""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
         let query = PFQuery(className:"CyclingPost")
        query.findObjectsInBackground(block: { (objects : [PFObject]?, error: Error?) -> Void in
            
            if error == nil {
                
                self.cyclePost = objects!
                // Do something with the found objects
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
        return cyclePost.count
    }
    
    var count = 0

    func replyClicked(sender:UIButton) {
        
        let buttonRow = sender.tag
        print("reply button clicked \(buttonRow)")
       count = count + 1
        posts.append(count)
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: count, section: 0)], with: .automatic)
        tableView.endUpdates()
        
    }
    
    var likeCount = 0
    
    func likeClicked(sender:UIButton) {
        likeCount = likeCount + 1
        if(likeCount%2 != 0) {
       sender.setImage(#imageLiteral(resourceName: "Like Filled-40"), for: .normal)
        }
        else {
            sender.setImage(#imageLiteral(resourceName: "Like-40"), for: .normal)
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
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        
        if(indexPath.row == 0) {
            let post:PFObject = cyclePost[(indexPath as NSIndexPath).row]
            let cell = CustomCell(frame:CGRect(x: 0, y: 0, width: self.view.frame.width, height: 100),title:"")
        
        
        cell.postTitle.text = post["title"] as! String!
        cell.eventTime.text = post["eventDate"] as! String!
        
        cell.likeButton.addTarget(self, action:#selector(likeClicked(sender:)), for: .touchUpInside)
        cell.replyButton.addTarget(self, action: #selector(replyClicked(sender:)), for: .touchUpInside)

        return cell
        }
        else if(indexPath.row == 1) {
            let cell = CommentCell(frame:CGRect(x: 0, y: 0, width: self.view.frame.width, height: 100),title:"")
            cell.commentText.text = commentArray[indexPath.row-1]
            return cell
        }
            
        else {
            let cell = PostCommentCell(frame:CGRect(x: 0, y: 0, width: self.view.frame.width, height: 100),title:"")
            commentArray.append(cell.commentText.text!)
            print("comment array inside cell \(commentArray)")
            cell.postCommentButton.addTarget(self, action: #selector(postComment(sender:)), for: .touchUpInside)
            return cell
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100;//Choose your custom row height
    }
    
    
    //custom cell programmatically
    class CustomCell: UITableViewCell {
        
        var postTitle: UILabel!
        var eventTime: UILabel!
        var notifyButton: UIButton!
        var likeButton: UIButton!
        var replyButton: UIButton!
        
        
        init(frame: CGRect, title: String) {
            super.init(style: UITableViewCellStyle.default, reuseIdentifier: "eventView")
            
            
            //post title label
            postTitle = UILabel(frame: CGRect(x: 80 ,y: 10,width: 150 ,height: 20))
            postTitle.textColor = UIColor.blue
            
            //event time label
            eventTime = UILabel(frame: CGRect(x: 80 ,y: 50,width: 150 ,height: 20))
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
