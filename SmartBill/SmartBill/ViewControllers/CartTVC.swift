//
//  BillDetailTVC.swift
//  SmartBill
//
//  Created by Sai Ramya Gajula on 4/15/24.
//

import UIKit
import AVFoundation

class CartTVC: UITableViewController {
    
    var billamount = 0
    var itemNames: [String] = []
    var amounts: [String] = []
    let continueSound: SystemSoundID = 1109
    
    @IBOutlet weak var generateBillBTN: UIBarButtonItem!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if FireStoreOperations.cartItems.isEmpty {
            generateBillBTN.isHidden = true
        }
        
        let prodprices = FireStoreOperations.productprices
        for bill in FireStoreOperations.cartItems {
            let amount = Int(Double(bill.value) * prodprices[bill.key]!)
            
            billamount += amount
            itemNames.append(bill.key)
            amounts.append(String(amount))
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FireStoreOperations.cartItems.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Bill", for: indexPath) as! CartCell

        cell.nameLBL.text = self.itemNames[indexPath.row]
        cell.quantityLBL.text = String(FireStoreOperations.cartItems[self.itemNames[indexPath.row]]!)
        cell.priceLBL.text = self.amounts[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           CGFloat(75)
    }
    
    @IBAction func generateBill(_ sender: UIBarButtonItem) {
        AudioServicesPlaySystemSound(continueSound)
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
            FireStoreOperations.cartItems.removeAll()
            self.generateBillBTN.isHidden = true
            self.tableView.reloadData()
            Task{
                await FireStoreOperations.fetchBills()
            }
            self.present(thanksAlert, animated: true, completion: nil)
        })
        
        alert.addAction(cancelAction)
        alert.addAction(ok)
        present(alert,animated: true,completion: nil)
    }
}
