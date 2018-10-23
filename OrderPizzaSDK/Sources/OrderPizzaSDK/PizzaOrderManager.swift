//
//  PizzaOrderManager.swift
//  OrderPizzaSDKDemo
//
//  Created by Sunil Chauhan on 06/10/18.
//  Copyright © 2018 Sunil Chauhan. All rights reserved.
//

import Foundation
import UIKit

/**
 The result model, signifying the result of the order.
 */
public enum Result {
    /**
     The pizza was ordered successfully. Passes orderId as `String`.
     */
    case ordered(String)

    /**
     The order has been cancelled (by cancel button on top-left of the view.
     */
    case cancelled

    /**
     The order has failed due to some internal error. `Swift.Error` is passed along with the case.
     */
    case failure(Swift.Error)
}


/**
 The publicly accessible interface to interact with pizza ordering UI.
 */
public final class PizzaOrderManager {

    /**
     Singleton of the PizzaOrderManager.
     */
    public static let shared = PizzaOrderManager()
    public typealias OrderCompletion = (Result) -> Void

    /**
     Presents the pizza ordering view on the window's root view controller.
     - Parameters:
         - viewController: The `UIViewController` instance or `nil` if you want to present this on window's rootViewController.
         - completion: The completion closure invoked when the order process is finished.
     */
    public func presentOrderPizzaView(on viewController: UIViewController? = nil, completion: @escaping OrderCompletion) {
        var presentingView: UIViewController
        if let presentingVc = viewController {
            presentingView = presentingVc
        } else {
            guard let presentingVc = rootViewController else {
                return
            }
            presentingView = presentingVc
        }

        let pizzaViewController = PizzaViewController { (result) in
            switch result {
            case .ordered, .cancelled:
                completion(result)
                self.dismissView()
            case .failure(let error):
                let alert = UIAlertController(title: "Oops!", message: "We could not process the request. Error: \(error)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
                    completion(result)
                    self.dismissView()
                }))
                alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { (_) in }))
                presentingView.present(alert, animated: true, completion: nil)
            }
        }   

        let navigationController = UINavigationController(rootViewController: pizzaViewController)
        presentingView.present(navigationController, animated: true, completion: nil)
    }

    /**
     Dismisses the view.
     */
    private func dismissView() {
        rootViewController?.dismiss(animated: true, completion: nil)
    }

    /**
     The rootViewController of the app, got from the delegate's `window` property. Might return `nil`.
     */
    private var rootViewController: UIViewController? {
        get {
            return UIApplication.shared.delegate?.window??.rootViewController
        }
    }
}
