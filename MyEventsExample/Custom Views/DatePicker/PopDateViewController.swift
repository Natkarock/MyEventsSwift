//
//  PopDateViewController.swift
//  MyEventsExample
//
//  Created by Karapats on 04/06/ 15.
//  Copyright © 2018 Karapats. All rights reserved.
//

import UIKit

protocol DataPickerViewControllerDelegate : class {
    
    func datePickerVCDismissed(_ date : Date?)
}

class PopDateViewController : UIViewController {
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    weak var delegate : DataPickerViewControllerDelegate?
    var datePickerMode: UIDatePickerMode = .dateAndTime
    
    var currentDate : Date? {
        didSet {
            updatePickerCurrentDate()
        }
    }
    
    convenience init() {
        
        self.init(nibName: "PopDatePickerView", bundle: nil)
    }
    
    private func updatePickerCurrentDate() {
        
        if let _currentDate = self.currentDate {
            if let `datePicker` = self.datePicker {
                datePicker.date = _currentDate
                datePicker.datePickerMode =  datePickerMode
            }
        }
       
        
    }
    
    @IBAction func okAction(_ sender: AnyObject) {
        
        self.dismiss(animated: true) {
            
            let nsdate = self.datePicker.date
            self.delegate?.datePickerVCDismissed(nsdate)
            
        }
    }
    
    override func viewDidLoad() {
        
        updatePickerCurrentDate()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        self.delegate?.datePickerVCDismissed(nil)
    }
}
