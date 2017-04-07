//
//  eventTableViewCell.swift
//  bearcatconnect
//
//  Created by Verma,Monish on 3/4/17.
//  Copyright © 2017 Verma,Monish. All rights reserved.
//

import UIKit

class eventTableViewCell: UITableViewCell {
    
    
    //MARK: Outlets
    
    @IBOutlet weak var notifyBTN: UIButton!
    
    @IBOutlet weak var replyBTN: UIButton!
    
    @IBOutlet weak var likeBTN: UIButton!
    
    @IBOutlet weak var eventsView: UIView!
    @IBOutlet weak var countLBL: UILabel!
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var eventTime: UILabel!
    @IBOutlet weak var eventDate: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
