//
//  PizzaCrust.swift
//  OrderPizzaSDKCore
//
//  Created by Sunil Chauhan on 04/10/18.
//  Copyright © 2018 Sunil Chauhan. All rights reserved.
//

import Foundation

/**
 The type of the crust of the pizza.
 */
public enum PizzaCrustType: CaseIterable, CustomStringConvertible {
    case handTossed
    case wheatThinCrust
    case cheeseBurst
    case freshPanPizza

    /**
     The name of the crust.
     */
    public func name() -> String {
        switch self {
        case .cheeseBurst:
            return "Cheese Burst Pizza"
        case .freshPanPizza:
            return "Fresh Pan Pizza"
        case .handTossed:
            return "Hand Tossed Pizza"
        case .wheatThinCrust:
            return "Wheat Thin Crust Pizza"
        }
    }

    /**
     The base price of the pizza.
     - Returns: the price of the pizza.
     */
    fileprivate func basePrice() -> Float {
        switch self {
        case .handTossed:
            return 20
        case .cheeseBurst:
            return 30
        case .freshPanPizza:
            return 25
        case .wheatThinCrust:
            return 23
        }
    }

    /**
     The description of the pizza.
     */
    public var description: String {
        return name()
    }
}

/**
 The pizza size, e.g. small, medium, large, etc.
 */
public enum PizzaCrustSize: CaseIterable, CustomStringConvertible {
    case small
    case medium
    case large

    /**
     The string representation of the size.
     */
    public func name() -> String {
        switch self {
        case .large:
            return "Large"
        case .medium:
            return "Medium"
        case .small:
            return "Small"
        }
    }

    /**
     The `rateVarient` of the pizza. The `rateVarient` can be multiplied with the `PizzaCrustType.basePrice` to get the actual rate.
     */
    fileprivate  func rateVarient() -> Float {
        switch self {
        case .small:
            return 1
        case .medium:
            return 1.25
        case .large:
            return 1.5
        }
    }

    /**
     The description of this crust size.
     */
    public var description: String {
        return name()
    }
}

/**
 The model that represents the type and size of the pizza.
 */
public struct PizzaCrust: CustomStringConvertible {
    /**
     The crsust type of the pizza.
     */
    public var type: PizzaCrustType

    /**
     The size of the pizza.
     */
    public var size: PizzaCrustSize

    /**
     The default initializer, passing type & size.
     */
    public init(type: PizzaCrustType, size: PizzaCrustSize) {
        self.type = type
        self.size = size
    }

    /**
     The description of the pizza size & type.
     */
    public func name() -> String {
        return size.name() + " " + type.name()
    }

    /**
     The total price for the type & size combination.
     */
    public func price() -> Float {
        return type.basePrice() * size.rateVarient()
    }

    /**
     The description of this type & size combination.
     */
    public var description: String {
        return name()
    }
}
