//
//  ListPickerViewController.swift
//  OrderPizzaSDKDemo
//
//  Created by Sunil Chauhan on 05/10/18.
//  Copyright © 2018 Sunil Chauhan. All rights reserved.
//

import UIKit

/**
 Helper class to show list of the items, allowing user to pick one item at a time. When selected, it calls the `selectionHandler` block.
 The list item can be any type that conforms to `CustomStringConvertible`.
 */
class ListPickerViewController: UIViewController {
    typealias ListPickerSelectionHandler = (CustomStringConvertible) -> Void

    let selectionHandler: ListPickerSelectionHandler
    let data: [CustomStringConvertible]

    let tableView: UITableView

    init(title: String, data:[CustomStringConvertible], selectionHandler: @escaping ListPickerSelectionHandler) {
        self.selectionHandler = selectionHandler
        self.data = data.sorted(by: { return $0.description.compare($1.description) == .orderedAscending})

        tableView = UITableView()

        super.init(nibName: nil, bundle: nil)

        self.title = title
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()

        tableView.register(ListPickerItemCell.self, forCellReuseIdentifier: ListPickerItemCell.reuseIdentifier)
    }
}

/**
 The tableView Delegate & Datasource.
 */
extension ListPickerViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListPickerItemCell.reuseIdentifier)
        cell?.textLabel?.text = data[indexPath.row].description
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectionHandler(data[indexPath.row])
    }
}
