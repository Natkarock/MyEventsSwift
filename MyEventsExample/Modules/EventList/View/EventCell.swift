//
//  TaskCell.swift
//  MyEventsExample
//
//  Created by Karapats on 31/05/ 15.
//  Copyright © 2018 Karapats. All rights reserved.
//

import UIKit

class EventCell: UITableViewCell {
    
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var switcher: UISwitch!
    @IBOutlet weak var labelDays: UILabel!
    
    var event: Event? {
        didSet {
            guard let event = event else {
                return
            }
            labelDate.text = formatDate(dateMillis: event.dateMs)
            labelTitle.text = event.title
            if  event.task_repeat_days == ""{
                labelDays.isHidden = true
                labelDate.isHidden = false
            }else{
                labelDate.isHidden = true
                labelDays.isHidden = false
                labelDays.text = event.repeatDaysArray
            }
        }
    }
    
    
    var contact:Contact? {
        didSet {
            guard  let contact = contact else {
                return
            }
            labelDays.isHidden = true
            labelDate.text = contact.contact_birthday
            labelTitle.text = contact.contact_name
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
