//
//  PopDatePicker.swift
//  MyEventsExample
//
//  Created by Karapats on 04/06/ 15.
//  Copyright © 2018 Karapats. All rights reserved.
//

import UIKit

public class PopDatePicker : NSObject, UIPopoverPresentationControllerDelegate, DataPickerViewControllerDelegate {
    
    public typealias PopDatePickerCallback = (_ newDate : Date)->()
    
    var datePickerVC : PopDateViewController
    var popover : UIPopoverPresentationController?
    var dataChanged : PopDatePickerCallback?
    var presented = false
    var offset : CGFloat = 8.0
    
    public override init() {
        
        datePickerVC = PopDateViewController()
        //self.textField = forTextField
        super.init()
    }
    
    public func pick(_ inViewController : UIViewController,for textField: UIView, mode:UIDatePickerMode, initDate : Date?, dataChanged : @escaping PopDatePickerCallback) {
        
        if presented {
            return  // we are busy
        }
        
        datePickerVC.delegate = self
        datePickerVC.modalPresentationStyle = UIModalPresentationStyle.popover
        //datePickerVC.preferredContentSize = CGSize(width: 500,height: 250)
        datePickerVC.datePickerMode = mode
        datePickerVC.currentDate = initDate
  
        
        popover = datePickerVC.popoverPresentationController
        if let _popover = popover {
            _popover.sourceView = textField
            _popover.sourceRect = CGRect(x: self.offset,y: textField.bounds.size.height,width: 0,height: 0)
            _popover.delegate = self
            self.dataChanged = dataChanged
            inViewController.present(datePickerVC, animated: true, completion: nil)
            presented = true
        }
    }
    
    //Added UITraitCollection parameter to fix the full screen popover stretch in iPhone 6s and 6s plus - Pramod Joshi
    public func adaptivePresentationStyle(
        for controller: UIPresentationController,
        traitCollection: UITraitCollection)
        -> UIModalPresentationStyle {
            return .none
    }
    
    func datePickerVCDismissed(_ date : Date?) {      
        /*if let _dataChanged = dataChanged {
            if let _date = date {
                _dataChanged(_date, textField)
            }
        }*/
        if let `date` = date, let `dataChanged` = dataChanged {
            dataChanged(date)
        }
        presented = false
    }
}
