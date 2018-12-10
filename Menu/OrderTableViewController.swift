//
//  OrderTableViewController.swift
//  Menu
//
//  Created by Sterre Smit on 05/12/2018.
//  Copyright © 2018 Sterre Smit. All rights reserved.
//

import UIKit

class OrderTableViewController: UITableViewController {
    var orderMinutes = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        
        NotificationCenter.default.addObserver(tableView, selector:
        #selector(UITableView.reloadData), name:
        MenuController.orderUpdatedNotification, object: nil)
    }

        override func tableView(_ tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            return MenuController.shared.order.menuItems.count
        }
    
    override func tableView(_ tableView: UITableView, cellForRowAt
        indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:
            "OrderCellIdentifier", for: indexPath)
        configure(cell, forItemAt: indexPath)
        return cell
    }
    
        func configure(_ cell: UITableViewCell, forItemAt indexPath:
            IndexPath) {
            let menuItem = MenuController.shared.order.menuItems[indexPath.row]
            cell.textLabel?.text = menuItem.name
            cell.detailTextLabel?.text = String(format: "$%.2f",
                                                menuItem.price)
            MenuController.shared.fetchImage(url: menuItem.imageURL)
            { (image) in
                guard let image = image else { return }
                DispatchQueue.main.async {
                    if let currentIndexPath =
                        self.tableView.indexPath(for: cell),
                        currentIndexPath != indexPath {
                        return
                    }
                    cell.imageView?.image = image
                    cell.setNeedsLayout()
                }
            }
        }
    override func tableView(_ tableView: UITableView, canEditRowAt
    indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath:
    IndexPath) {
        if editingStyle == .delete { MenuController.shared.order.menuItems.remove(at: indexPath.row)
    }
    }
    override func prepare(for segue: UIStoryboardSegue, sender:
    Any?) {
    if segue.identifier == "ConfirmationSegue" {
    let orderConfirmationViewController = segue.destination
    as! OrderConfirmationViewController
    orderConfirmationViewController.minutes = orderMinutes
    }
    }
   
    @IBAction func submitTapped(_ sender: Any) {
        let orderTotal =
            MenuController.shared.order.menuItems.reduce(0.0)
            { (result, menuItem) -> Double in
                return result + menuItem.price
        }
        let formattedOrder = String(format: "$%.2f", orderTotal)
        
        let alert = UIAlertController(title: "Confirm Order", message: "You are about to submit your order with a total of \(formattedOrder)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Submit",
                                      style: .default) { action in
                                        self.uploadOrder()
        })
        alert.addAction(UIAlertAction(title: "Cancel",
                                      style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    func uploadOrder() {
        let menuIds = MenuController.shared.order.menuItems.map
        { $0.id }
        MenuController.shared.submitOrder(forMenuIDs: menuIds)
        { (minutes) in
            DispatchQueue.main.async {
                if let minutes = minutes {
                    self.orderMinutes = minutes
                    self.performSegue(withIdentifier: "ConfirmationSegue", sender: nil)
                }
            }
        }
    }
    @IBAction func unwindToOrderList(segue: UIStoryboardSegue){
        if segue.identifier == "DismissConfirmation" { MenuController.shared.order.menuItems.removeAll()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt
    indexPath: IndexPath) -> CGFloat {
        return 100
    }

    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


