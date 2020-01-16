//
//  WeekdayButton.swift
//  MyEventsExample
//
//  Created by Karapats on 03/06/ 15.
//  Copyright © 2018 Karapats. All rights reserved.
//

import UIKit

class WeekdayButton: UIButton {
    
    var selectColor: UIColor = .gray
    var unSelectColor:UIColor = .black
    override var isSelected: Bool {
        didSet {
            if  isSelected{
                backgroundColor = selectColor
            } else {
                backgroundColor = unSelectColor
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setProperties()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setProperties()
    }
    
    func setProperties(){
        layer.cornerRadius = bounds.size.width*0.5
        backgroundColor = unSelectColor
    }
    
    func invalidate(){
        if (isSelected){
            backgroundColor = selectColor
        }else {
            backgroundColor = unSelectColor
        }
        //frame = CGRect (x: frame.origin.x, y: frame.origin.y , width: frame.width, height: frame.width)
        //print(frame)
        //print(bounds)
        //layer.cornerRadius =  0.5 * bounds.width
    }
    
    
    


    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
