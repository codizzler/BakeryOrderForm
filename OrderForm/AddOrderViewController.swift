//
//  AddOrderViewController.swift
//  OrderForm
//
//  Created by Cody Taylor on 12/19/15.
//  Copyright © 2015 SweetsandEatsBakery. All rights reserved.
//

import UIKit

class AddOrderViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var deliveryDate: UIDatePicker!
    @IBOutlet weak var callerName: UITextField!
    @IBOutlet weak var callerNumber: UITextField!
    @IBOutlet weak var callerEmail: UITextField!
    @IBOutlet weak var receiptType: UISegmentedControl!
    @IBOutlet weak var deliveryName: UITextField!
    @IBOutlet weak var deliveryNumber: UITextField!
    @IBOutlet weak var deliveryAddress: UITextView!
    @IBOutlet weak var fullOrder: UITextView!
    @IBOutlet weak var addCard: UISwitch!
    @IBOutlet weak var cardMessage: UITextView!
    @IBOutlet weak var havePaid: UISwitch!
    @IBOutlet weak var saveOrder: UIBarButtonItem!
    var placeholderLabel: UILabel!
    var placeholderCardLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deliveryAddress.delegate = self
        cardMessage.delegate = self
        placeholderLabel = UILabel()
        placeholderLabel.text = "Delivery Address"
        placeholderLabel.font = UIFont.italicSystemFontOfSize(deliveryAddress.font!.pointSize)
        placeholderLabel.sizeToFit()
        deliveryAddress.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPointMake(5, deliveryAddress.font!.pointSize / 2)
        placeholderLabel.textColor = UIColor(white: 0, alpha: 0.3)
        placeholderLabel.hidden = !deliveryAddress.text.isEmpty
        placeholderCardLabel = UILabel()
        placeholderCardLabel.text = "Card Message"
        placeholderCardLabel.font = UIFont.italicSystemFontOfSize(cardMessage.font!.pointSize)
        placeholderCardLabel.sizeToFit()
        cardMessage.addSubview(placeholderCardLabel)
        placeholderCardLabel.frame.origin = CGPointMake(5, cardMessage.font!.pointSize / 2)
        placeholderCardLabel.textColor = UIColor(white: 0, alpha: 0.3)
        placeholderCardLabel.hidden = !cardMessage.text.isEmpty

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "dismissAndSave" {
            let order = Order(dDate: deliveryDate.date, cName: callerName.text!, cNumber: callerNumber.text!, rType: receiptType.titleForSegmentAtIndex(receiptType.selectedSegmentIndex)!, cEmail: callerEmail.text!, dName: deliveryName.text!, dNumber: deliveryNumber.text!, dAddress: deliveryAddress.text!, fOrder: fullOrder.text!, aCard: addCard.on, cMessage: cardMessage.text!, pReceived: havePaid.on)
            OrderStore.sharedInstance.add(order)
            NSNotificationCenter.defaultCenter().postNotificationName("load", object: nil)
        }
    }
    
    func textViewDidChange(textView: UITextView) {
        placeholderLabel.hidden = !deliveryAddress.text.isEmpty
        placeholderCardLabel.hidden = !cardMessage.text.isEmpty
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
