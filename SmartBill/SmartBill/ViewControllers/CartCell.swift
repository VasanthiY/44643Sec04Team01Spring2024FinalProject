//
//  BillDetailCell.swift
//  SmartBill
//
//  Created by Krishna Vasanthi on 4/17/24.
//

import UIKit

class CartCell: UITableViewCell {
    
    @IBOutlet weak var nameLBL: UILabel!
    
    @IBOutlet weak var quantityLBL: UILabel!
    
    @IBOutlet weak var priceLBL: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
