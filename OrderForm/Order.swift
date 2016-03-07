//
//  Order.swift
//  OrderForm
//
//  Created by Cody Taylor on 12/19/15.
//  Copyright © 2015 SweetsandEatsBakery. All rights reserved.
//

import Foundation
import RealmSwift

class Order: Object {
    dynamic var deliveryDate: NSDate = NSDate()
    dynamic var callerName: String = ""
    dynamic var callerNumber: String = ""
    dynamic var receiptType: String = ""
    dynamic var callerEmail: String = ""
    dynamic var deliveryName: String = ""
    dynamic var deliveryNumber: String = ""
    dynamic var deliveryAddress: String = ""
    dynamic var fullOrder: String = ""
    dynamic var addCard: Bool = false
    dynamic var cardMessage: String = ""
    dynamic var paymentReceived: Bool = false
    dynamic var section: Int = 0
    dynamic var sectionString: String = ""
    
    convenience init(dDate: NSDate, cName: String, cNumber: String, rType: String, cEmail: String, dName: String, dNumber: String, dAddress: String, fOrder: String, aCard: Bool, cMessage: String, pReceived: Bool) {
        self.init()
        self.deliveryDate = dDate
        self.callerName = cName
        self.callerNumber = cNumber
        self.receiptType = rType
        self.callerEmail = cEmail
        self.deliveryAddress = dAddress
        self.deliveryName = dName
        self.deliveryNumber = dNumber
        self.fullOrder = fOrder
        self.addCard = aCard
        self.cardMessage = cMessage
        self.paymentReceived = pReceived
        self.sectionString = NSDateFormatter.localizedStringFromDate(dDate, dateStyle: .ShortStyle, timeStyle: .NoStyle)
    }
}