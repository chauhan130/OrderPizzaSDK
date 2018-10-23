//
//  ListPickerItemCell.swift
//  OrderPizzaSDKDemo
//
//  Created by Sunil Chauhan on 05/10/18.
//  Copyright © 2018 Sunil Chauhan. All rights reserved.
//

import UIKit

/**
 The tableViewCell that shows the item of the list that can be selected. When selected, the row is highlighted and the √ accessory is shown.
 */
class ListPickerItemCell: UITableViewCell {
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.accessoryType = selected ? .checkmark : .none
    }
}
