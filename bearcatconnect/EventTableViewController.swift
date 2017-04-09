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

    var posts:[Int] = [0]
    let titleArray = ["a","b","c"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
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
        return posts.count
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
    
    func likeClicked(sender:UIButton) {
        
        let buttonRow = sender.tag
        print("button clicked \(buttonRow)")
        sender.setImage(#imageLiteral(resourceName: "Like Filled-40"), for: .normal)
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       //let cell = tableView.dequeueReusableCell(withIdentifier: "eventView", for: indexPath) as! eventTableViewCell
        
        //let cellHeight = tableView(self.tableView, heightForRowAt: IndexPath(row: indexPath.row, section: indexPath.section))
        if(indexPath.row == 0) {
            let cell = CustomCell(frame:CGRect(x: 0, y: 0, width: self.view.frame.width, height: 100),title:"")
        
        cell.postCount.text = "1"
        cell.postTitle.text = "20 mile trail"
        cell.eventTime.text = "10:00 pm 23rd Jan"
        
        cell.likeButton.addTarget(self, action:#selector(likeClicked(sender:)), for: .touchUpInside)
        cell.replyButton.addTarget(self, action: #selector(replyClicked(sender:)), for: .touchUpInside)
       
        
        

        return cell
        }
        else if(indexPath.row == 1) {
            let cell = CommentCell(frame:CGRect(x: 0, y: 0, width: self.view.frame.width, height: 100),title:"")
            return cell
        }
        else {
            let cell = PostCommentCell(frame:CGRect(x: 0, y: 0, width: self.view.frame.width, height: 100),title:"")
            return cell
        }
    }
    
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100;//Choose your custom row height
    }
    
    
    //custom cell programmatically
    class CustomCell: UITableViewCell {
        
        var postCount: UILabel!
        var postTitle: UILabel!
        var eventTime: UILabel!
        var notifyButton: UIButton!
        var likeButton: UIButton!
        var replyButton: UIButton!
        
        
        init(frame: CGRect, title: String) {
            super.init(style: UITableViewCellStyle.default, reuseIdentifier: "eventView")
            
            print("width: \(self.frame.width)")
            print("height: \(self.frame.height)")
            //post count label
            postCount = UILabel(frame: CGRect(x: 10,y: 10,width: 20 ,height: 20))
            postCount.textColor = UIColor.black
            
            //post title label
            postTitle = UILabel(frame: CGRect(x: 80 ,y: 10,width: 150 ,height: 20))
            postTitle.textColor = UIColor.black
            
            //event time label
            eventTime = UILabel(frame: CGRect(x: 80 ,y: 50,width: 150 ,height: 20))
            eventTime.textColor = UIColor.black
            
            //notify button
            notifyButton = UIButton(frame: CGRect(x: 5, y: 50, width: 50, height: 50))
            notifyButton.setImage(#imageLiteral(resourceName: "Bell-40"), for: .normal)
            
            //like button
            likeButton = UIButton(frame: CGRect(x: 350, y: 5, width: 50, height: 50))
            likeButton.setImage(#imageLiteral(resourceName: "Like-40"), for: .normal)
            
            //reply button
            replyButton = UIButton(frame: CGRect(x: 350, y: 50, width: 50, height: 50))
            replyButton.setImage(#imageLiteral(resourceName: "Reply Arrow-40"), for: .normal)
            
            //adding to subview
           
            addSubview(postCount)
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
        
        var commentText: UITextField!
        
        
        
        
        init(frame: CGRect, title: String) {
            super.init(style: UITableViewCellStyle.default, reuseIdentifier: "commentView")
            
            print("width: \(self.frame.width)")
            print("height: \(self.frame.height)")
            //post count label
            commentText = UITextField(frame: CGRect(x: 10,y: 10,width: 370 ,height: 80))
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
            super.init(style: UITableViewCellStyle.default, reuseIdentifier: "commentView")
            
            print("width: \(self.frame.width)")
            print("height: \(self.frame.height)")
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
