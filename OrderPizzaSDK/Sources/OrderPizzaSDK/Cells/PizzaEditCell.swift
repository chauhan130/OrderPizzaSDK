//
//  PizzaEditCell.swift
//  OrderPizzaSDKDemo
//
//  Created by Sunil Chauhan on 05/10/18.
//  Copyright © 2018 Sunil Chauhan. All rights reserved.
//

import UIKit

/**
 The cell to display the pizza detail, that can be changed. Shows disclosureIndicator.
 */
final class PizzaEditCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        accessoryType = .disclosureIndicator
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
