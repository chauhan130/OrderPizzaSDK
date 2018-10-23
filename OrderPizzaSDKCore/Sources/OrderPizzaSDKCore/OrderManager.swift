//
//  OrderManager.swift
//  OrderPizzaSDKCore
//
//  Created by Sunil Chauhan on 04/10/18.
//

import Foundation

/**
 The class responsible to place an order.
 */

public final class OrderManager {

    /**
     Use this `shared` to call methods on `OrderManager`.
     */
    public static let shared = OrderManager()


    /**
     Don't let others to initialize this class, use `sharedInstance` instead.
     */
    private init() { }


    /**
     The `Result` of the order placing operation.
     */
    public enum Result {
        /**
         The `success` case when the order is places successfully. Passes the `orderId` associated with this order.
         */
        case success(String)

        /**
         The `failure` case, when something goes wrong. Passes the actual `Error` expressing the failure.
         */
        case failure(Swift.Error)
    }


    /**
     The Error enum that confirms to `Swift.Error` & `CustomStringConvertible`. For now there is only one case, i.e. `notEnoughFlavors`,
     when user tries to order pizza that has less than 2 flavors.
     */
    public enum Error: Swift.Error, CustomStringConvertible {
        case notEnoughFlavors

        public var description: String {
            switch self {
            case .notEnoughFlavors:
                return "You need to add two flavors."
            }
        }
    }


    /**
     The alias for `Result` passing closure.
     */
    public typealias FinalizePizzaOrderCompletion = (Result) -> Void


    /**
     Actually puts the order.
     - Parameters:
        - pizza: The `Pizza` instance that is to be ordered.
        - completion: The order completion handler that passes the `Result` of the ordering operation.
     */
    public func finalizeOrder(pizza: Pizza, completion: FinalizePizzaOrderCompletion) {
        guard pizza.flavorsIncluded.count == Pizza.maximumFlavorsAllowed else {
            completion(.failure(Error.notEnoughFlavors))
            return
        }

        // Call API to order the pizza here.
        completion(.success("\(arc4random())"))
    }
}
