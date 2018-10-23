//
//  PizzaFlavor.swift
//  OrderPizzaSDKCore
//
//  Created by Sunil Chauhan on 04/10/18.
//  Copyright © 2018 Sunil Chauhan. All rights reserved.
//

import Foundation

/**
 The pizza flavor enum, that lists all the possible flavors available.
 */
public enum PizzaFlavor: CaseIterable, CustomStringConvertible {
    case pepperoni
    case mushrooms
    case onions
    case sausage
    case bacon
    case crispCapsicum
    case blackOlives
    case greenPeppers
    case goldenCorn

    /**
     The price of each pizza flavor.
     */
    public func price() -> Float {
        switch self {
        case .bacon:
            return 10
        case .blackOlives:
            return 8
        case .crispCapsicum:
            return 15
        case .greenPeppers:
            return 7
        case .mushrooms:
            return 12
        case .onions:
            return 6
        case .pepperoni:
            return 11
        case .sausage:
            return 13
        case .goldenCorn:
            return 8
        }
    }

    /**
     The half price of the pizza, for easier calculation.
     */
    public func halfPrice() -> Float {
        return price() / 2.0
    }

    /**
     The string representation of the flavor.
     */
    public func name() -> String {
        switch self {
        case .pepperoni:
            return "Pepperoni"
        case .mushrooms:
            return "Mushrooms"
        case .onions:
            return "Onions"
        case .sausage:
            return "Sausage"
        case .bacon:
            return "Bacon"
        case .crispCapsicum:
            return "Crisp Capsicum"
        case .blackOlives:
            return "Black Olives"
        case .greenPeppers:
            return "GreenPeppers"
        case .goldenCorn:
            return "Golden Corn"
        }
    }

    /**
     The description of the flavor.
     */
    public var description: String {
        return name()
    }
}
