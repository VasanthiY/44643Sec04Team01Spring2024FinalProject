//
//  BillHistoryCell.swift
//  SmartBill
//
//  Created by Krishna Vasanthi on 4/17/24.
//

import UIKit

class BillHistoryCell: UITableViewCell {

    @IBOutlet weak var items: UILabel!
    
    @IBOutlet weak var totalCost: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
