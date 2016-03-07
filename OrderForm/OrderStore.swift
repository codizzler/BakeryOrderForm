//
//  OrderStore.swift
//  OrderForm
//
//  Created by Cody Taylor on 12/19/15.
//  Copyright © 2015 SweetsandEatsBakery. All rights reserved.
//

import Foundation
import RealmSwift

class OrderStore {
    let realm = try! Realm()
    var currentOrders = try! Realm().objects(Order).sorted("deliveryDate").filter("deliveryDate >= %@", NSCalendar.currentCalendar().startOfDayForDate(NSDate()))
    var pastOrders = try! Realm().objects(Order).sorted("deliveryDate", ascending: false).filter("deliveryDate < %@", NSCalendar.currentCalendar().startOfDayForDate(NSDate()))
    
    class var sharedInstance: OrderStore {
        struct Static {
            static let instance = OrderStore()
        }
        return Static.instance
    }
    
    var count: Int {
        get {
            return currentOrders.count + pastOrders.count
        }
    }
    
    func add(order: Order) {
        try! realm.write {
            realm.add(order)
        }
    }
    
    func replace(order: Order, atIndex index: Int) {
        try! realm.write {
            if index < currentOrders.count {
                realm.delete(currentOrders[index])
            } else {
                realm.delete(pastOrders[index - currentOrders.count])
            }
            realm.add(order)
        }
    }
    
    func get(index: Int) -> Order {
        if index < currentOrders.count {
            return currentOrders[index]
        } else {
            return pastOrders[index - currentOrders.count]
        }
    }
    
    func removeOrderAtIndex(index: Int) {
        try! realm.write {
            if index < currentOrders.count {
                realm.delete(currentOrders[index])
            } else {
                realm.delete(pastOrders[index - currentOrders.count])
            }
        }
    }
    
    func getIndex(order: Order) -> Int {
        for var i = 0; i < self.count; ++i {
            if order.deliveryDate == self.get(i).deliveryDate && order.callerName == self.get(i).callerName && order.callerNumber == self.get(i).callerNumber && order.callerEmail == self.get(i).callerEmail && order.receiptType == self.get(i).receiptType && order.deliveryName == self.get(i).deliveryName && order.deliveryAddress == self.get(i).deliveryAddress && order.deliveryNumber == self.get(i).deliveryNumber && order.fullOrder == self.get(i).fullOrder && order.addCard == self.get(i).addCard && order.cardMessage == self.get(i).cardMessage && order.paymentReceived == self.get(i).paymentReceived {
                return i
            }
        }
        return -1
    }
}