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
}
