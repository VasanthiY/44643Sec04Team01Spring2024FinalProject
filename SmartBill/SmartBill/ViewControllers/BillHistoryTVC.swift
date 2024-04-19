//
//  BillHistoryTVC.swift
//  SmartBill
//
//  Created by Manideep IOS on 4/15/24.
//

import UIKit


class BillHistoryTVC: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return FireStoreOperations.billsinfo.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           CGFloat(75)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "billHistory", for: indexPath) as! BillHistoryCell

        let bill = FireStoreOperations.billsinfo[indexPath.row]
        cell.items.text = bill.items
        cell.totalCost.text = String(bill.price)
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: "Delete the bill", handler: {
            action, view, controller in
            
            let billitems = FireStoreOperations.billsinfo[indexPath.row].items
            FireStoreOperations.billsinfo.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .none)
            FireStoreOperations.deletebill(name: billitems)
            
        })
        
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let update = UIContextualAction(style: .normal, title: "Increase the Bill price to 100", handler: {
            action, view, controller in
            
            let billitems = FireStoreOperations.billsinfo[indexPath.row].items
            FireStoreOperations.billsinfo.insert(Bill(items: billitems, price: 100), at: indexPath.row)
            tableView.reloadData()
            FireStoreOperations.updatebill(name: billitems, price:100)
            
        })
        
        return UISwipeActionsConfiguration(actions: [update])
    }
}
