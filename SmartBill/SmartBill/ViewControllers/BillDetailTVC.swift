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
        var billdetails:[billDetail] = []
        var billamount = 0
        var billitems = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let prodprices = FireStoreOperations.productprices
                
                for bill in bills{
                    billdetails.append(billDetail(name: bill.key, qty: bill.value, total: Double(bill.value) * prodprices[bill.key]!))
                }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return bills.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Bill", for: indexPath)
        
        let bill = billdetails[indexPath.row]
        
        cell.textLabel?.text = bill.name + "    " + String(bill.qty) + "   " + String(bill.total)

        // Configure the cell...

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           CGFloat(75)
       }
    
    @IBAction func generateBill(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "save bill", message: "Save the Generated Bill ?", preferredStyle: .alert)
                
        let ok = UIAlertAction(title: "ok", style: .default, handler: {_ in
            let data = [
            
                "items": self.billitems.description,
                "totalcost":self.billamount
            ]
            
            FireStoreOperations.saveBill(data: data)
        })
        
        alert.addAction(ok)
        present(alert,animated: true,completion: nil)
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
