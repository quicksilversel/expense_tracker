//
//  transactionDataTableViewCell.swift
//  expense_tracker
//
//  Created by Zoe L on 2021/01/23.
//

import UIKit

class transactionDataTableViewCell: UITableViewCell {

    @IBOutlet weak var dateCell: UILabel!
    @IBOutlet weak var amountCell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
