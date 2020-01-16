//
//  EventDetailEventDetailViewController.swift
//  MyEventsExample
//
//  Created by Natalya Karapats on 20/07/2018.
//  Copyright © 2018 natateam. All rights reserved.
//

import UIKit

class EventDetailViewController: UIViewController, EventDetailViewInput {

    var output: EventDetailViewOutput!
    @IBOutlet weak var weeakDayView: WeekdayView!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var stackDate: UIStackView!
    @IBOutlet weak var stackTime: UIStackView!
    let popDatePicker = PopDatePicker()
    var presenter: EventDetailViewOutput!
    var targetType: FCollectiontype = .events
    var data:DocumentSerializable = Event(dictionary: [:])!
    var activityIndicator = UIActivityIndicatorView()

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }
    
    func setupInitialState() {
        initComponents()
        setData(data: data)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    func setData(data: DocumentSerializable) {
        if data is Event {
            let event = data as! Event
            if event.task_date != "" {
                labelDate.text = event.task_date
            }
            if event.task_time != "" {
                labelTime.text = event.task_time
            }
            titleField.text = event.title
            descriptionField.text = event.desc
            if targetType == .events {
                weeakDayView.isHidden = true
            }
            if targetType == .alarms{
                stackDate.isHidden = true
                weeakDayView.selectedDays = event.task_repeat_days
            }
            print(event.eventId)
            if event.eventId == "" {
                btnDelete.isHidden = true
            }else {
                btnAdd.titleLabel?.text = "Изменить"
            }
        } else if data is Contact {
            let contact = data as! Contact
            if contact.contact_birthday != "" {
                labelDate.text = contact.contact_birthday
            }
            titleField.placeholder = "Имя"
            titleField.text = contact.contact_name
            descriptionField.isHidden = true
            stackTime.isHidden = true
            weeakDayView.isHidden = true
            if contact.contact_id == "" {
                btnDelete.isHidden = true
            }else {
                btnAdd.titleLabel?.text = "Изменить"
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initComponents(){
        weeakDayView.selectColor = ThemeManager.currentTheme().secondaryColor
        weeakDayView.unSelectColor = .gray
        weeakDayView.invalidate()
        let dateTabRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.showDatePicker(for:)))
        stackDate.addGestureRecognizer(dateTabRecognizer)
        stackDate.isUserInteractionEnabled = true
        let timeTabRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.showTimePicker(for:)))
        stackTime.addGestureRecognizer(timeTabRecognizer)
        stackTime.isUserInteractionEnabled = true
        activityIndicator = setupActivityIndicator()
        //navigationController?.navigationBar.tit
        
    }
    
    @objc func showDatePicker(for sender: Any){
        popDatePicker.pick(self, for: labelDate,mode: .date, initDate: Date()){
            date in self.labelDate.text = (date.formatForDay()) as String
        }
    }
    
    
    @objc func showTimePicker(for sender: Any){
        popDatePicker.pick(self, for: labelTime, mode: .time, initDate: Date()){
            date in self.labelTime.text = (date.formatForTime()) as String
        }
    }
    
    func updateDataFromView(){
        
    }
    
    
    @IBAction func updateData(_ sender: Any){
        if titleField.text == "" {
            showError(message: "Введите название события")
            return
        }
        if  labelDate.text == "dd.mm.yyyy" && targetType != .alarms{
            showError(message: "Введите дату события")
            return
        }
        if targetType == .alarms && weeakDayView.getSelectedDays() == ""{
            showError(message: "Выберите хотя бы один день недели")
            return
        }
        if data is Event {
            var event = data as! Event
            event.title = (titleField?.text)!
            event.desc = (descriptionField?.text)!
            event.task_time = (labelTime?.text)!
            event.task_date = (labelDate?.text)!
            event.task_repeat_days = weeakDayView.getSelectedDays()
            if targetType == .events {
                event.dateMs = Int(formatDateWith(string: event.task_date + " " +  event.task_time).millisecondsSince1970)
                print (event.dateMs)
            }
            
            event.task_type = targetType.type
            data = event
        }else if data is Contact {
            var contact = data as! Contact
            contact.contact_birthday = (labelDate?.text)!
            contact.contact_date_ms = Int(formatDateWith(string: contact.contact_birthday + " 00:00").millisecondsSince1970)
            contact.contact_name = (titleField?.text)!
            data = contact
        }
        start(indicator: activityIndicator)
        presenter.updateData(data: data, type: targetType)
        succesAction()
    }
    
    
    @IBAction func deleteData(_ sender: Any){
        showOkCancelAlert(title: "Внимание", text: "Вы действительно хотите удалить данное событие?"){
            _ in
            self.start(indicator: self.activityIndicator)
            self.presenter.deleteData(data: self.data, type: self.targetType)
            self.succesAction()
        }
    }
    
    
    func succesAction() {
        stop(indicator: activityIndicator)
        navigationController?.popViewController(animated: true)
        
    }
    
    func showError(message: String) {
        stop(indicator: activityIndicator)
        showTextAlert(title: "Внимание", text: message, okaction: {_ in })
    }
    
    
}
