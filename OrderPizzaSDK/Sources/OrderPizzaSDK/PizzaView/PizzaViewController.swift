//
//  PizzaViewController.swift
//  OrderPizzaSDKDemo
//
//  Created by Sunil Chauhan on 05/10/18.
//  Copyright © 2018 Sunil Chauhan. All rights reserved.
//

import UIKit
import OrderPizzaSDKCore

/**
 The model used to show the organized rows in a sectioned tableView. It lists all the possible values for each of the sections.
 You can omit some of the rows when you actually define sections.
 */
enum PizzaSections {
    enum PizzaDetails {
        case details
    }
    enum CrustData {
        case type
        case size
    }
    enum Flavors {
        case primary
        case secondary
    }
    enum Price {
        case totalPrice
    }

    case pizzaName([PizzaDetails])
    case crustInfo([CrustData])
    case flavors([Flavors])
    case price([Price])

    func numberOfRows() -> Int {
        switch self {
        case .crustInfo(let rows):
            return rows.count
        case .flavors(let rows):
            return rows.count
        case .pizzaName(let rows):
            return rows.count
        case .price(let rows):
            return rows.count
        }
    }

    func title() -> String {
        switch self {
        case .crustInfo:
            return "Crust Details"
        case .flavors:
            return "Select any two Flavors"
        case .pizzaName:
            return "Pizza"
        case .price:
            return "Price"
        }
    }
}


/**
 The view controller responsible to show pizza details like image, full description, crust type, pizza size, flavors and total price.
 */
class PizzaViewController: UIViewController {

    lazy var tableView = UITableView(frame: CGRect.zero, style: .grouped)
    private let sections: [PizzaSections] = [.pizzaName([.details]), .crustInfo([.type, .size]), .flavors([.primary, .secondary]), .price([.totalPrice])]

    typealias Completion = (Result) -> Void

    let completion: Completion

    /**
     The pizz that is rendered in this tableview. Any change in the pizza will reload the tableview.
     */
    var pizza: Pizza {
        didSet {
            tableView.reloadData()
        }
    }

    /**
     Basic initializer.
     - Parameters:
         - completion: The block that will be executed when the order process is finished.
     */
    init(completion: @escaping Completion) {
        self.completion = completion

        let crust = PizzaCrust(type: .handTossed, size: .medium)
        pizza = Pizza(crust: crust)

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Order Pizza! 🍕"

        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])

        tableView.tableFooterView = UIView()

        tableView.register(PizzaDetailCell.self, forCellReuseIdentifier: PizzaDetailCell.reuseIdentifier)
        tableView.register(PizzaEditCell.self, forCellReuseIdentifier: PizzaEditCell.reuseIdentifier)
        tableView.register(PriceCell.self, forCellReuseIdentifier: PriceCell.reuseIdentifier)

        tableView.dataSource = self
        tableView.delegate = self

        let orderItem = UIBarButtonItem(title: "Order", style: .done, target: self, action: #selector(orderTapped))
        navigationItem.rightBarButtonItem = orderItem

        let cancelItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(dismissView))
        navigationItem.leftBarButtonItem = cancelItem

        // To reset the flavors while debugging..
        #if DEBUG
        let resetItem = UIBarButtonItem(title: "Reset", style: .done, target: self, action: #selector(resetFlavorsTapped))
        navigationItem.leftBarButtonItem = resetItem
        #endif
    }

    @objc
    private func orderTapped() {
        OrderManager.shared.finalizeOrder(pizza: pizza) { (result) in
            switch result {
            case .success(let orderId):
                let alert = UIAlertController(title: "Success", message: "Your 🍕 order was successful. Order id: \(orderId)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Great!", style: .default, handler: { (_) in
                    self.completion(.ordered(orderId))
                }))
                present(alert, animated: true, completion: nil)
            case .failure(let error):
                if let orderError = error as? OrderManager.Error, orderError == OrderManager.Error.notEnoughFlavors  {
                    let alert = UIAlertController(title: "Oops!", message: "Could not process the pizza order. Error: \(error)", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
                } else {
                    completion(.failure(error))
                }
            }
        }
    }

    @objc
    func resetFlavorsTapped() {
        pizza.flavorsIncluded.forEach({ _ = pizza.remove(flavor: $0) })
    }

    @objc
    private func dismissView() {
        completion(.cancelled)
    }
}

/**
 The PizzaViewController implementing UITableViewDelegate & UITableViewDataSource.
 */
extension PizzaViewController: UITableViewDelegate, UITableViewDataSource {

    private enum Constants {
        static let firstRowHeight = CGFloat(150)
        static let normalRowHeight = CGFloat(50)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].numberOfRows()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = sections[indexPath.section]
        switch section {
        case .pizzaName:
            return Constants.firstRowHeight
        default:
            return Constants.normalRowHeight
        }
    }

    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let section = sections[indexPath.section]
        switch section {
        case .pizzaName, .price:
            return nil
        default:
            return indexPath
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        switch section {
        case .pizzaName:
            let cell = tableView.dequeueReusableCell(withIdentifier: PizzaDetailCell.reuseIdentifier) as! PizzaDetailCell
            cell.pizzaTitle.text = pizza.name()
            return cell
        case .crustInfo(let rows):
            let row = rows[indexPath.row]
            switch row {
            case .type:
                let cell = tableView.dequeueReusableCell(withIdentifier: PizzaEditCell.reuseIdentifier) as! PizzaEditCell
                cell.textLabel?.text = "Crust Type"
                cell.detailTextLabel?.text = pizza.crust.type.name()
                return cell
            case .size:
                let cell = tableView.dequeueReusableCell(withIdentifier: PizzaEditCell.reuseIdentifier) as! PizzaEditCell
                cell.textLabel?.text = "Pizza Size"
                cell.detailTextLabel?.text = pizza.crust.size.name()
                return cell
            }
        case .flavors(let rows):
            let row = rows[indexPath.row]
            switch row {
            case .primary:
                let cell = tableView.dequeueReusableCell(withIdentifier: PizzaEditCell.reuseIdentifier) as! PizzaEditCell
                cell.textLabel?.text = "Primary Flavor"
                cell.detailTextLabel?.text = pizza.flavorsIncluded.first?.name() ?? "Select"
                return cell
            case .secondary:
                let cell = tableView.dequeueReusableCell(withIdentifier: PizzaEditCell.reuseIdentifier) as! PizzaEditCell
                cell.textLabel?.text = "Secondary Flavor"
                if pizza.flavorsIncluded.count > 1 {
                    cell.detailTextLabel?.text = pizza.flavorsIncluded[1].name()
                } else {
                    cell.detailTextLabel?.text = "Select"
                }
                return cell
            }
        case .price:
            let cell = tableView.dequeueReusableCell(withIdentifier: PriceCell.reuseIdentifier) as! PriceCell
            cell.textLabel?.text = "Total Price"
            cell.detailTextLabel?.text = "\(pizza.totalPrice())"
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = sections[indexPath.section]
        switch section {
        case .pizzaName, .price:
            break
        case .crustInfo(let rows):
            let row = rows[indexPath.row]
            switch row {
            case .type:
                presentPizzaDetailPicker(title: "Pizza Type", data: PizzaCrustType.allCases)
            case .size:
                presentPizzaDetailPicker(title: "Pizza Size", data: PizzaCrustSize.allCases)
            }
        case .flavors(let rows):
            let row = rows[indexPath.row]
            switch row {
            case .primary:
                presentPizzaDetailPicker(title: "Primary Flavor", data: PizzaFlavor.allCases)
            case .secondary:
                presentPizzaDetailPicker(title: "Secondary Flavor", data: PizzaFlavor.allCases)
            }
        }
    }

    /**
     Presents the list picker to choose one item from the list.
     - Parameters:
        - title: The title of the list picker view.
        - data: Array of `CustomStringConvertible` that will be displayed in each item of the list.
     */
    func presentPizzaDetailPicker(title: String, data: [CustomStringConvertible]) {
        let listPicker = ListPickerViewController(title: title, data: data) { (selectedItem) in
            if let crustType = selectedItem as? PizzaCrustType {
                self.pizza.crust.type = crustType
            } else if let crustSize = selectedItem as? PizzaCrustSize {
                self.pizza.crust.size = crustSize
            } else if let flavor = selectedItem as? PizzaFlavor {
                //FIXME: Find some better approach here.
                if title == "Primary Flavor" {
                    if self.pizza.flavorsIncluded.count > 1 {
                        let secondaryFlavor = self.pizza.flavorsIncluded[1]
                        _ = self.pizza.remove(flavor: secondaryFlavor)
                        _ = self.pizza.remove(flavor: self.pizza.flavorsIncluded[0])
                        _ = self.pizza.add(flavor: flavor)
                        _ = self.pizza.add(flavor: secondaryFlavor)
                    } else {
                        if self.pizza.flavorsIncluded.count > 0 {
                            _ = self.pizza.remove(flavor: self.pizza.flavorsIncluded[0])
                        }
                        _ = self.pizza.add(flavor: flavor)
                    }
                } else {
                    if self.pizza.flavorsIncluded.count > 1 {
                        _ = self.pizza.remove(flavor: self.pizza.flavorsIncluded[1])
                    }
                    _ = self.pizza.add(flavor: flavor)
                }
            }
        }
        navigationController?.pushViewController(listPicker, animated: true)
    }
}
