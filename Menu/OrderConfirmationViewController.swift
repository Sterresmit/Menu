//
//  OrderConfirmationViewController.swift
//  Restaurant
//
//  Created by Sterre Smit on 09/12/2018.
//  Copyright © 2018 Sterre Smit. All rights reserved.
//

import UIKit

class OrderConfirmationViewController: UIViewController {

    @IBOutlet weak var timeRemainingLabel: UILabel!
    var minutes: Int!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeRemainingLabel.text = "Thank you for your order! Your wait time is approximately \(minutes!) minutes."
        // Do any additional setup after loading the view.
    }

    
}
