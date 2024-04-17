//
//  BillHistoryTVC.swift
//  SmartBill
//
//  Created by Manideep IOS on 4/15/24.
//

import UIKit
struct Billitems: Codable{
let items: String
let price: Double
 
}

class BillHistoryTVC: UITableViewController {
    
    var billitems:[Billitems]=[]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let bills = FireStoreOperations.billsinfo
        
        for bill in bills{
            billitems.append(Billitems(items: bill.items, price: bill.price))
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return billitems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "History", for: indexPath)
      
        // Configure the cell...
        let bill = billitems[indexPath.row]
        cell.textLabel?.text = bill.items.description + " " + String(bill.price)
        
        return cell
    }
}
