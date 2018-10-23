![Documentation](./docs/badge.svg)

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

    // Create instance of `Pizza`
    var myPizza = Pizza(crust: PizzaCrust(type: .cheeseBurst, size: .large))

    // Add 2 flavors
    _ = myPizza.add(flavor: .bacon)
    _ = myPizza.add(flavor: .blackOlives)

    // ..and finally order the pizza.!
    OrderManager.shared.finalizeOrder(pizza: myPizza) { (result) in
        switch result {
        case .success(let orderId):
            print("Order is successful. OrderId: \(orderId)")
        case .failure:
            print("Could not process the order. Error: \(error)")
        }
    }
