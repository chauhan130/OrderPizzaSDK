//
//  Pizza.swift
//  OrderPizzaSDKCore
//
//  Created by Sunil Chauhan on 04/10/18.
//  Copyright © 2018 Sunil Chauhan. All rights reserved.
//

import Foundation

/**
 The basic 🍕 model, that represents the pizza size (i.e. Small/Medium/Large), crust, and possible flavors.
 It returns pizza full description & price to make the job easy.
 The `Pizza` model is `CustomStringConvertible`, so it returns the full name of the pizza.
 */
public struct Pizza: CustomStringConvertible {

    /**
     The list of the flavors those have been included in this pizza. (Read Only)
     */
    public private(set) var flavorsIncluded = [PizzaFlavor]()

    /**
     The instance representing the crust type and the size of the pizza.
     */
    public var crust: PizzaCrust// = PizzaCrust(type: PizzaCrustType.handTossed, size: PizzaCrustSize.medium)

    /**
     Number of flavors allowed in one pizza.
     */
    public static let maximumFlavorsAllowed = 2

    /**
     The basic pizza initializer.
     - Parameters:
         - crust: The `PizzaCrust` instance .
     */
    public init(crust: PizzaCrust) {
        self.crust = crust
    }

    /**
     Adds the specified flavor to this pizza.
     - Parameters:
        - flavor: The `PizzaFlavor` to be added.
     - Returns: `true` if the pizza was added successfully. Returns `false` if there are maximum flavors included already.
     */
    public mutating func add(flavor: PizzaFlavor) -> Bool {
        guard flavorsIncluded.count < Pizza.maximumFlavorsAllowed else {
            // maximum flavors added.
            return false
        }
        flavorsIncluded.append(flavor)
        return true
    }

    /**
     Removes specified flavor from this pizza.
     - Parameters:
         - flavor: The `PizzaFlavor` to be removed.
     - Returns: `true` if the the flavor is found and removed. `false` if the flavor is not added at all.
     */
    public mutating func remove(flavor: PizzaFlavor) -> Bool {
        guard let index = flavorsIncluded.firstIndex(of: flavor) else {
            // Flavor `flavor` is not included.
            return false
        }
        flavorsIncluded.remove(at: index)
        return true
    }

    /**
     Returns total price of the pizza, considering all the features.
     */
    public func totalPrice() -> Float {
        return crust.price() + flavorsIncluded.reduce(0, { $0 + $1.halfPrice() })
    }

    /**
     Full description of the pizza along with included flavors..
     */
    public func name() -> String {
        var title = crust.name()
        if flavorsIncluded.count > 0 {
            let flavorsTitle = flavorsIncluded.map({ $0.name() }).joined(separator: ", ")
            title.append(" with " + flavorsTitle)
        }
        return title
    }

    /**
     The description of the pizza.
     */
    public var description: String {
        return name()
    }
}
