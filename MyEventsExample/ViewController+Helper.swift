//
//  ViewController+Helper.swift
//  MyEventsExample
//
//  Created by Karapats on 01/06/ 15.
//  Copyright © 2018 Karapats. All rights reserved.
//

import Foundation
import  UIKit

extension UIViewController {
    func showTextAlert(title:String,text:String, okaction: @escaping (UIAlertAction)->Void){
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: okaction))
        self.present(alert, animated: true)
    }
    
    func showOkCancelAlert(title:String,text:String, okaction: @escaping (UIAlertAction)->Void){
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: okaction))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func setupActivityIndicator()->UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height:40))
        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        indicator.center = self.view.center
        indicator.hidesWhenStopped = true
        self.view.addSubview(indicator)
        return indicator
    }
    
    func start(indicator: UIActivityIndicatorView){
        indicator.startAnimating()
    }
    
    func stop(indicator:UIActivityIndicatorView){
        indicator.stopAnimating()
    }
    

    
   
    
    
    
}
