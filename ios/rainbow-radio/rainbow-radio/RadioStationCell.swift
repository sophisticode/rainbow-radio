//
//  RadioStationCellTableViewCell.swift
//  rainbow-radio
//
//  Created by Markus Zehnder on 12.08.16.
//  Copyright © 2016 Sophisticode. All rights reserved.
//

import UIKit

class RadioStationCell: UITableViewCell {

    @IBOutlet var titleLabel : UILabel?
    @IBOutlet var symbolImageView : UIImageView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
