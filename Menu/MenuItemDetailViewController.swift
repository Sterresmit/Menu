//
//  MenuItemDetailViewController.swift
//  Restaurant
//
//  Created by Sterre Smit on 05/12/2018.
//  Copyright © 2018 Sterre Smit. All rights reserved.
//

import UIKit

class MenuItemDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var addToOrder: UIButton!
    
    
    @IBAction func addToOrderButtonTapped(_ sender: Any) {
        UIView.animate(withDuration: 0.3) {
            self.addToOrder.transform =
            CGAffineTransform(scaleX: 2.0, y: 2.0)
            self.addToOrder.transform =
            CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
        MenuController.shared.order.menuItems.append(menuItem)
        
    }
    
    var menuItem: MenuItem!

    
    override func viewDidLoad() {
        addToOrder.layer.cornerRadius = 5.0
        super.viewDidLoad()

        updateUI()
    }
    func updateUI() {
        titleLabel.text = menuItem.name
        priceLabel.text = String(format: "$%.2f", menuItem.price)
        descriptionLabel.text = menuItem.detailText
        MenuController.shared.fetchImage(url: menuItem.imageURL)
        { (image) in
            guard let image = image else { return }
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
    }

    

    


}
