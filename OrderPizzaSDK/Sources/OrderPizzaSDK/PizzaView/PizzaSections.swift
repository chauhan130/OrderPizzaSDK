//
//  PizzaSections.swift
//  OrderPizzaSDKDemo
//
//  Created by Sunil Chauhan on 05/10/18.
//  Copyright © 2018 Sunil Chauhan. All rights reserved.
//

import Foundation

///**
// The model used to show the organized rows in a sectioned tableView. It lists all the possible values for each of the sections.
// You can omit some of the rows when you actually define sections.
// */
//enum PizzaSections {
//    enum PizzaDetails {
//        case details
//    }
//    enum CrustData {
//        case type
//        case size
//    }
//    enum Flavors {
//        case primary
//        case secondary
//    }
//    enum Price {
//        case totalPrice
//    }
//
//    case pizzaName([PizzaDetails])
//    case crustInfo([CrustData])
//    case flavors([Flavors])
//    case price([Price])
//
//    func numberOfRows() -> Int {
//        switch self {
//        case .crustInfo(let rows):
//            return rows.count
//        case .flavors(let rows):
//            return rows.count
//        case .pizzaName(let rows):
//            return rows.count
//        case .price(let rows):
//            return rows.count
//        }
//    }
//
//    func title() -> String {
//        switch self {
//        case .crustInfo:
//            return "Crust Details"
//        case .flavors:
//            return "Select any two Flavors"
//        case .pizzaName:
//            return "Pizza"
//        case .price:
//            return "Price"
//        }
//    }
//}
