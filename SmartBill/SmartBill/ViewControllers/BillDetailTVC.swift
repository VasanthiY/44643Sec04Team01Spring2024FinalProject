//
//  BillDetailTVC.swift
//  SmartBill
//
//  Created by Sai Ramya Gajula on 4/15/24.
//

import UIKit

struct billDetail{
    let name:String
    let qty:Int
    let total:Double
}

class BillDetailTVC: UITableViewController {
    
    var bills = [String:Int]()
    var billDetails:[billDetail] = []
    var billamount = 0
    var itemNames: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let prodprices = FireStoreOperations.productprices
        for bill in bills {
            let amount = Int(Double(bill.value) * prodprices[bill.key]!)
            billamount += amount
            itemNames.append(bill.key)
            billDetails.append(billDetail(name: bill.key, qty: bill.value, total: Double(amount)))
        }
        
        print(billamount)
        print(itemNames)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bills.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Bill", for: indexPath) as! BillDetailCell
        
        let bill = billDetails[indexPath.row]
        
        cell.nameLBL.text = bill.name
        cell.quantityLBL.text = String(bill.qty)
        cell.priceLBL.text = String(bill.total)
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           CGFloat(75)
       }
    
    @IBAction func generateBill(_ sender: UIBarButtonItem) {
        let thanksAlert = UIAlertController(title: "Thank You", message: "Thanks for shopping with us!", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        thanksAlert.addAction(okAction)
        
        let alert = UIAlertController(title: "Confirm Order", message: "Would you like to purchase?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                
        let ok = UIAlertAction(title: "ok", style: .default, handler: {_ in
            let data = [
            
                "items": self.itemNames.joined(separator: ", "),
                "totalcost":self.billamount
            ]
            
            FireStoreOperations.saveBill(data: data)
            self.billDetails = []
            self.tableView.reloadData()
            
            self.present(thanksAlert, animated: true, completion: nil)
        })
        
        alert.addAction(cancelAction)
        alert.addAction(ok)
        present(alert,animated: true,completion: nil)
    }
}
