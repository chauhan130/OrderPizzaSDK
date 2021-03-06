![Swift](https://img.shields.io/badge/swift-4.2-brightgreen.svg)

# Developer Friendly Pizza SDK!

There are three projects:
1. `OrderPizzaSDKCore` : Has core code to actually order the pizza. It does not have any platform specific code, so in future we could use this for Mac OS, Watch OS, TV OS, etc. More information in it's own [ReadMe](./OrderPizzaSDKCore/README.md) file.  ![Documentation](./OrderPizzaSDKCore/docs/badge.svg)
 2. `OrderPizzaSDK` : Provides iOS UI interface to `OrderPizzaSDKCore` framework.   More information in its own  [ReadMe](./OrderPizzaSDK/README.md) file. ![Documentation](./OrderPizzaSDK/docs/badge.svg)
 3. `OrderPizzaSDKDemo` : Demonstrates how to use the `OrderPizzaSDK`.  

Most of the code is documented. Most of class/structs/enums/methods have comments explaining its purpose. The documentation is generated for `OrderPizzaSDKCore` & `OrderPizzaSDK` and they are in their `docs` directory.

The `OrderPizzaSDKCore` can be installed with Cocoapods & Swift Package Manager. We are planning to support the Carthage as well. The `OrderPizzaSDK` can be installed with Cocoapods. We are planning to support the Carthage as well.
