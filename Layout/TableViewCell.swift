//
//  TableViewCell.swift
//  Layout
//
//  Created by Andrew on 03/10/23.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var userView: UIView!
    
    @IBOutlet weak var button: UIButton!
    
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
