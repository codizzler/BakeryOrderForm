//
//  MasterViewController.swift
//  OrderForm
//
//  Created by Cody Taylor on 12/18/15.
//  Copyright © 2015 SweetsandEatsBakery. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var sectionsInTable: [String] = []
    
    func getSectionItems(section: Int) -> [Order] {
        var sectionItems = [Order]()
        
        // loop through the testArray to get the items for this sections's date
        for var i = 0; i < OrderStore.sharedInstance.count; ++i {
            let order = OrderStore.sharedInstance.get(i)
            let df = NSDateFormatter()
            df.dateFormat = "MM/dd/yyyy"
            let dateString = df.stringFromDate(order.deliveryDate)
            
            // if the item's date equals the section's date then add it
            if dateString == sectionsInTable[section] as NSString {
                sectionItems.append(order)
            }
        }
        
        return sectionItems
    }
    
    func getOrderIndex(indexPath: NSIndexPath) -> Int {
        var index = 0
        for var i = 0; i < indexPath.section; ++i {
            let secItems: [Order] = getSectionItems(i)
            for var j = 0; j < secItems.count; ++j {
                ++index
            }
        }
        return index + indexPath.row
    }
    
    func update() {
        let df = NSDateFormatter()
        df.dateFormat = "MM/dd/yyyy"
        sectionsInTable = []
        for var i = 0; i < OrderStore.sharedInstance.count; ++i {
            let dateString = df.stringFromDate(OrderStore.sharedInstance.get(i).deliveryDate)
            
            // create sections NSSet so we can use 'containsObject'
            let sections: NSSet = NSSet(array: sectionsInTable)
            
            // if sectionsInTable doesn't contain the dateString, then add it
            if !sections.containsObject(dateString) {
                sectionsInTable.append(dateString)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "loadList:",name:"load", object: nil)
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        update()

        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }
    
    func loadList(notification: NSNotification){
        //load data here
        update()
        self.tableView.reloadData()
    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = sender {
                let order = OrderStore.sharedInstance.get(getOrderIndex(indexPath as! NSIndexPath))
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = order
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("showDetail", sender: indexPath)
    }

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sectionsInTable.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.getSectionItems(section).count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Configure the cell...
        let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
        
        // get the items in this section
        let sectionItems = self.getSectionItems(indexPath.section)
        // get the item for the row in this section
        let order = sectionItems[indexPath.row]
        cell.textLabel!.text = order.callerName
        cell.textLabel!.font = UIFont.boldSystemFontOfSize(18)
        cell.textLabel!.textColor = UIColor.purpleColor()
        cell.detailTextLabel?.text = NSDateFormatter.localizedStringFromDate(order.deliveryDate, dateStyle: .NoStyle, timeStyle: .ShortStyle) + " " + NSDateFormatter.localizedStringFromDate(order.deliveryDate, dateStyle: .ShortStyle, timeStyle: .NoStyle)
        
        return cell
    }
    
    // print the date as the section header title
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionsInTable[section]
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            OrderStore.sharedInstance.removeOrderAtIndex(getOrderIndex(indexPath))
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }

}

