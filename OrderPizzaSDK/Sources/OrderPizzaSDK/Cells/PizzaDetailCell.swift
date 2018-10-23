//
//  PizzaDetailCell.swift
//  OrderPizzaSDKDemo
//
//  Created by Sunil Chauhan on 05/10/18.
//  Copyright © 2018 Sunil Chauhan. All rights reserved.
//

import UIKit

/**
 A hack to get rid of manually defining those `reuseIdentifier` for UITableViewCell.
 */
public protocol Reusable: class {
    static var reuseIdentifier: String { get }
}

public extension Reusable {
    public static var reuseIdentifier: String {
        return String(describing: self)
    }
}

/**
 Implementation of `Reusable` protocol to get rid of `reuseIdentifier` definition.
 */
extension UITableViewCell: Reusable {}


/**
 The tableView cell to display the pizza image and full description.
 */
class PizzaDetailCell: UITableViewCell {
    private enum Constants {
        static let labelSpacing = CGFloat(10)
    }

    let pizzaImage = UIImageView()
    let pizzaTitle = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        pizzaImage.backgroundColor = UIColor.lightGray
        pizzaImage.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(pizzaImage)
        NSLayoutConstraint.activate([
            pizzaImage.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            pizzaImage.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            pizzaImage.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor),
            pizzaImage.widthAnchor.constraint(equalTo: pizzaImage.heightAnchor)
            ])

        pizzaTitle.translatesAutoresizingMaskIntoConstraints = false
        pizzaTitle.numberOfLines = 0
        contentView.addSubview(pizzaTitle)
        NSLayoutConstraint.activate([
            pizzaTitle.leadingAnchor.constraint(equalTo: pizzaImage.trailingAnchor, constant: Constants.labelSpacing),
            pizzaTitle.trailingAnchor.constraint(lessThanOrEqualTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.labelSpacing),
            pizzaTitle.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: Constants.labelSpacing),
            pizzaTitle.bottomAnchor.constraint(lessThanOrEqualTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.labelSpacing)
            ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
