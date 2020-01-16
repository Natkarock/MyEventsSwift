//
//  EventListEventListViewController.swift
//  MyEventsExample
//
//  Created by Natalya Karapats on 19/07/2018.
//  Copyright © 2018 natateam. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class EventListViewController: UITableViewController, IndicatorInfoProvider,EventListViewInput {

    

    

    
    var tasktype:FCollectiontype = .events
    var presenter: EventListViewOutput!
    var events:[DocumentSerializable]?{
        didSet {
            stop(indicator: activityIndicator)
            self.tableView.reloadData()
        }
    }
    
    
    var activityIndicator = UIActivityIndicatorView()
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getEntitiesByType(type: tasktype)
    }
    
    func goToDetailVC(tasktype: FCollectiontype, data: DocumentSerializable) {
        presenter.goToDetailVC(tasktype: tasktype, data: data)
    }
    
    func getNavigationController() -> UINavigationController? {
        return navigationController
    }
    

    
    func getEntitiesByType(type: TargetFType) {
        start(indicator: activityIndicator)
        presenter.getEntitiesByType(type:type)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewIsReady()
    }
    
    func setupInitialState() {
        initComponents()
    }
    
    func initComponents(){
        activityIndicator =  setupActivityIndicator()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 300
        let nib = UINib.init(nibName: "EventCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "EventCell")
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
        return events?.count ?? 0
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: tasktype.type)
    }
    
    func setEvents(events: [DocumentSerializable]) {
        self.events = events
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath)as? EventCell
        if let cell = cell {
            if let data = events?[indexPath.row]{
                if  data is Event {
                    cell.event = data as? Event
                }else if data is Contact {
                    cell.contact = data as? Contact
                }
            }
            cell.imgIcon.image = getImgFor(taskType: tasktype)
            if tasktype.type == "todo"{
                cell.switcher.isHidden = true
            }
        }
        return cell ?? EventCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goToDetailVC(tasktype: tasktype, data: events![(tableView.indexPathForSelectedRow?.row)!])
    }
    
    
    
    
    
    
    func getImgFor(taskType: FCollectiontype)-> UIImage{
        switch taskType.type {
        case "todo":
            return #imageLiteral(resourceName: "icon_todo")
        case "repeat":
            return #imageLiteral(resourceName: "icon_repeat")
        case "birthday":
            return #imageLiteral(resourceName: "icon_birthday")
        default:
            return #imageLiteral(resourceName: "icon_repeat")
        }
    }
    
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let eventDetailVc = segue.destination as? EventDetailViewController{
            if let `events` = events {
                if ((tableView.indexPathForSelectedRow?.row)! < events.count) {
                    eventDetailVc.targetType = tasktype
                    eventDetailVc.presenter = EventDetailPresenter(view: eventDetailVc)
                    eventDetailVc.data = events[(tableView.indexPathForSelectedRow?.row)!]
                }
            }
        }
    }*/
}
