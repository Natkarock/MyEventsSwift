//
//  Parent.swift
//  MyEventsExample
//
//  Created by Karapats on 31/05/ 15.
//  Copyright © 2018 Karapats. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import FirebaseUI
import Contacts
import ContactsUI

class ParentVC: ButtonBarPagerTabStripViewController {
    
    
    let mainTheme = ThemeManager.currentTheme()
    var contactStore = CNContactStore()
    
    override func viewDidLoad() {
        initFireAuth()
        initPageTabbar()
        super.viewDidLoad()
        self.askForContactAccess()
        LocalNotificationManager.sharedInstance.setAlarms()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    private func initPageTabbar(){
        // change selected bar color
        settings.style.buttonBarBackgroundColor = mainTheme.mainColor
        settings.style.buttonBarItemBackgroundColor = mainTheme.mainColor
        settings.style.selectedBarBackgroundColor = .red
        settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 14)
        settings.style.selectedBarHeight = 5.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .white
        settings.style.buttonBarItemsShouldFillAvailiableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = self?.mainTheme.titleTextColor
            newCell?.label.textColor = self?.mainTheme.titleTextColor
        }
    }
    
    
    func initFireAuth(){
        let authUI = FUIAuth.defaultAuthUI()
        // You need to adopt a FUIAuthDelegate protocol to receive callback
        guard let user = Auth.auth().currentUser else {
            authUI?.delegate = self
            let providers: [FUIAuthProvider] = [
                FUIGoogleAuth(),
                ]
            authUI?.providers = providers
            let authViewController = authUI?.authViewController()
            self.show(authViewController!, sender: ParentVC.self)
            return
        }
    }
    
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let child_1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EventListVC") as! EventListViewController
        child_1.tasktype = FCollectiontype.events
        //child_1.presenter = EventListPresenter(view:child_1)
        let child_2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EventListVC") as! EventListViewController
        child_2.tasktype = FCollectiontype.alarms
        //child_2.presenter = EventListPresenter(view:child_2)
        let child_3 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EventListVC") as! EventListViewController
        child_3.tasktype = FCollectiontype.contacts
        //child_3.presenter = ContactListPresenter(view:child_3)
        return [child_1,child_2,child_3]
    }
    
    
    
    @IBAction func plusbtnAction(_ sender :Any){
        if let controller =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EventDetailtVC") as? EventDetailViewController{
            switch currentIndex {
            case 0:
                controller.data = Event(dictionary: [:])!
                controller.targetType = .events
            case 1:
                controller.data = Event(dictionary: [:])!
                controller.targetType = .alarms
            default:
                break
            }
            //controller.presenter = EventDetailPresenter(view: controller)
            if currentIndex != 2 {
                pushEventController(controller: controller)
            }else {
                showContactPicker()
            }
        }
    }
    
    func pushEventController(controller: UIViewController){
        let transition = CATransition()
        transition.duration = 2.35
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionFade
        self.navigationController?.view.layer.add(transition, forKey: nil)
        navigationController?.pushViewController(controller, animated: false)
    }
    
    
    func showContactPicker(){
        let contactPicker = CNContactPickerViewController()
        contactPicker.delegate = self
        self.present(contactPicker, animated: true, completion: nil)
    }
    
    
    
    
}


extension ParentVC: FUIAuthDelegate {
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        if let `error` = error {
            UIControl().sendAction(#selector(NSXPCConnection.suspend),
                                   to: UIApplication.shared, for: nil)
        }
    }
}

extension ParentVC : CNContactPickerDelegate {
    func askForContactAccess() {
        let authorizationStatus = CNContactStore.authorizationStatus(for: CNEntityType.contacts)
        switch authorizationStatus {
        case .denied, .notDetermined:
            self.contactStore.requestAccess(for: CNEntityType.contacts, completionHandler: { (access, accessError) -> Void in
                if !access {
                    if authorizationStatus == CNAuthorizationStatus.denied {
                        DispatchQueue.main.async {
                            let message = "\(accessError!.localizedDescription)\n\nПожалуйста предоставьте доступ к своим контактам"
                            let alertController = UIAlertController(title: "Контакты", message: message, preferredStyle: UIAlertControllerStyle.alert)
                            
                            let dismissAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action) -> Void in
                            }
                            
                            alertController.addAction(dismissAction)
                            
                            self.present(alertController, animated: true, completion: nil)
                        }
                    }
                }
            })
        default:
            break
        }
    }
    
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addNewContact"), object: nil, userInfo: ["contactToAdd": contact])
        var contactData = Contact(dictionary: [:])
        contactData?.contact_name = contact.givenName + " " + contact.familyName
        if contact.phoneNumbers.count > 0 {
            contactData?.contact_phone = ((contact.phoneNumbers[0].value as! CNPhoneNumber).value(forKey: "digits") as? String)!
        }
        if contact.emailAddresses.count > 0 {
            contactData?.contact_email = contact.emailAddresses[0].value as String
        }
        if let controller =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EventDetailtVC") as? EventDetailViewController {
            controller.data = contactData ?? Contact(dictionary: [:])!
            controller.targetType = .contacts
            //controller.presenter = EventDetailPresenter(view: controller)
            pushEventController(controller: controller)
        }
    }
    
}

