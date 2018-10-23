//
//  ViewController.swift
//  OrderPizzaSDKDemo
//
//  Created by Sunil Chauhan on 07/10/18.
//  Copyright © 2018 Sunil Chauhan. All rights reserved.
//

import UIKit
import OrderPizzaSDK

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)

        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])

        button.setTitle("Order Pizza!", for: .normal)
        button.addTarget(self, action: #selector(openPizzaOrderViewTapped), for: .touchUpInside)
    }

    @objc
    func openPizzaOrderViewTapped() {
        PizzaOrderManager.shared.presentOrderPizzaView { (result) in
            switch result {
            case .ordered(let orderId):
                print("Order placed successfully. OrderId: \(orderId)")
            case .cancelled:
                print("Cancelled by the user.")
            case .failure(let error):
                print("Could not process the order. Error: \(error)")
            }
        }
    }
}
