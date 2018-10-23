[![Documentation](./docs/badge.svg)]

# OrderPizzaSDKCore

This is core framework for ordering Pizza. It does not have any UI specific code, so you can create your own UI using this framework.

## Installation
### Cocoapods:
[CocoaPods](https://cocoapods.org/)  is a dependency manager for Cocoa projects. 

    pod 'OrderPizzaSDKCore'

### Swift Package Manager:

    dependencies: [ 
        .package(url: "https://github.com/chauhan130/OrderPizzaSDKCore.git", from: "4.0.0") 
    ]

## Documentation
The project includes the documentation in `docs` directory. You can always have a look at it.

## Example Usage:

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
