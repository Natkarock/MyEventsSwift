//
//  WeekdayView.swift
//  MyEventsExample
//
//  Created by Karapats on 03/06/ 15.
//  Copyright © 2018 Karapats. All rights reserved.
//

import UIKit
import Foundation

class WeekdayView: UIStackView {
    
    var btnList:[WeekdayButton] = []
    var selectColor:UIColor = .black {
        didSet {
            for btn in btnList {
                btn.selectColor = selectColor
                btn.invalidate()
            }
        }
    }
    
    var unSelectColor:UIColor  = .gray {
        didSet {
            for btn in btnList {
                btn.unSelectColor = unSelectColor
                btn.invalidate()
            }
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setView()
    }
    
    func setView(){
        clearStackView()
        self.alignment = .fill
        self.distribution = .fillEqually
        self.spacing = 20
        let days = DateFormatter().veryShortWeekdaySymbols
        days?.forEach{
            let button = createButton(labelText: $0)
            btnList.append(button)
            self.addArrangedSubview(button)
            
        }
        invalidate()
    }
    
    func invalidate(){
        for btn in self.arrangedSubviews  {
            if  let `btn` = btn as? WeekdayButton {
                btn.selectColor = selectColor
                btn.unSelectColor = unSelectColor
                btn.invalidate()
            }
            
        }
    }
    
    
    
    
    
    private func clearStackView() {
        btnList = []
        self.arrangedSubviews.forEach({
            $0.removeFromSuperview()
            self.removeArrangedSubview($0)
        })
    }
    
    
    private func createButton(labelText: String) -> WeekdayButton{
        let button = WeekdayButton()
        button.setTitle(labelText, for: .normal)
        button.selectColor = selectColor
        button.unSelectColor = unSelectColor
        button.addTarget(self, action: #selector(self.buttonPressed), for: .touchUpInside)
        //button.frame = CGRect(x: button.frame.origin.x, y: button.frame.origin.y, height: button.frame.width, width: button.frame.width)
        
        return button
    }
    
    
    @objc func buttonPressed(btn:WeekdayButton) {
        print("btn pressed")
        btn.isSelected = !btn.isSelected
    }
    
    func getSelectedDays()->String{
        var selectedDays = ""
        for i in 0..<btnList.count {
            if btnList[i].isSelected {
                selectedDays += "\(i)  "
            }
        }
        return selectedDays
    }
    
    /*func setSelectedDays(days: String){
        let daysList = days.split(separator: " ")
        for i in daysList {
            btnList[Int(i) ?? 0].isSelected = true
        }
    }*/
    
    var selectedDays:String = "" {
        didSet {
            let daysList = selectedDays.split(separator: " ")
            for i in daysList {
                let index = Int(i) ?? -1
                if index != -1 {
                    btnList[index].isSelected = true
                }
            }
        }

    }
    
    
    
    
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
