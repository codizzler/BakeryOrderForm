//
//  DetailViewController.swift
//  OrderForm
//
//  Created by Cody Taylor on 12/18/15.
//  Copyright © 2015 SweetsandEatsBakery. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var deliveryDate: UIDatePicker!
    @IBOutlet weak var callerName: UITextField!
    @IBOutlet weak var callerNumber: UITextField!
    @IBOutlet weak var receiptType: UISegmentedControl!
    @IBOutlet weak var callerEmail: UITextField!
    @IBOutlet weak var deliveryName: UITextField!
    @IBOutlet weak var deliveryNumber: UITextField!
    @IBOutlet weak var deliveryAddress: UITextView!
    @IBOutlet weak var fullOrder: UITextView!
    @IBOutlet weak var addCard: UISwitch!
    @IBOutlet weak var cardMessage: UITextView!
    @IBOutlet weak var havePaid: UISwitch!

    var detailItem: Order? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let order = self.detailItem {
            if let deliveryDate = self.deliveryDate {
                deliveryDate.setDate(order.deliveryDate, animated: false)
            }
            if let callerName = self.callerName {
                callerName.text = order.callerName
            }
            if let callerNumber = self.callerNumber {
                callerNumber.text = order.callerNumber
            }
            if let receiptType = self.receiptType {
                if order.receiptType == "None" {
                    receiptType.selectedSegmentIndex = 0
                } else if order.receiptType == "Text" {
                    receiptType.selectedSegmentIndex = 1
                } else {
                    receiptType.selectedSegmentIndex = 2
                }
            }
            if let callerEmail = self.callerEmail {
                callerEmail.text = order.callerEmail
            }
            if let deliveryName = self.deliveryName {
                deliveryName.text = order.deliveryName
            }
            if let deliveryAddress = self.deliveryAddress {
                deliveryAddress.text = order.deliveryAddress
            }
            if let deliveryNumber = self.deliveryNumber {
                deliveryNumber.text = order.deliveryNumber
            }
            if let fullOrder = self.fullOrder {
                fullOrder.text = order.fullOrder
            }
            if let addCard = self.addCard {
                addCard.on = order.addCard
            }
            if let cardMessage = self.cardMessage {
                cardMessage.text = order.cardMessage
            }
            if let havePaid = self.havePaid {
                havePaid.on = order.paymentReceived
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "dismissAndUpdate" {
            let order = Order(dDate: deliveryDate.date, cName: callerName.text!, cNumber: callerNumber.text!, rType: receiptType.titleForSegmentAtIndex(receiptType.selectedSegmentIndex)!, cEmail: callerEmail.text!, dName: deliveryName.text!, dNumber: deliveryNumber.text!, dAddress: deliveryAddress.text!, fOrder: fullOrder.text!, aCard: addCard.on, cMessage: cardMessage.text!, pReceived: havePaid.on)
            OrderStore.sharedInstance.add(order)
            OrderStore.sharedInstance.removeOrderAtIndex(OrderStore.sharedInstance.getIndex(self.detailItem!))
            NSNotificationCenter.defaultCenter().postNotificationName("load", object: nil)
        }
    }


}

