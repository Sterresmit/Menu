//
//  Order.swift
//  Restaurant
//
//  Created by Sterre Smit on 05/12/2018.
//  Copyright © 2018 Sterre Smit. All rights reserved.
//

import UIKit
struct Order: Codable {
    var menuItems: [MenuItem]

    init(menuItems: [MenuItem] = []) {
        self.menuItems = menuItems
    }
}
