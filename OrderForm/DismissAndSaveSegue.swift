//
//  DismissAndSaveSegue.swift
//  OrderForm
//
//  Created by Cody Taylor on 12/19/15.
//  Copyright © 2015 SweetsandEatsBakery. All rights reserved.
//

import UIKit

@objc(DismissAndSaveSegue) class DismissAndSaveSegue: UIStoryboardSegue {
    
    override func perform() {
        if let controller = sourceViewController.presentingViewController {
            controller.dismissViewControllerAnimated(true, completion: nil)
        }
    }
}
