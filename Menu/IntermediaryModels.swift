//
//  IntermediaryModels.swift
//  Restaurant
//
//  Created by Sterre Smit on 05/12/2018.
//  Copyright © 2018 Sterre Smit. All rights reserved.
//

import UIKit
struct Categories: Codable {
    let categories: [String]
}
struct PreparationTime: Codable {
    let prepTime: Int

    enum CodingKeys: String, CodingKey {
        case prepTime = "preparation_time"
    }
}
