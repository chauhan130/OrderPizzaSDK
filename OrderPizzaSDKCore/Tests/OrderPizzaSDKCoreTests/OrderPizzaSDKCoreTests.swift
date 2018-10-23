//
//  OrderPizzaSDKCoreTests.swift
//  OrderPizzaSDKCoreTests
//
//  Created by Sunil Chauhan on 04/10/18.
//  Copyright © 2018 Sunil Chauhan. All rights reserved.
//

import XCTest
@testable import OrderPizzaSDKCore

class OrderPizzaSDKCoreTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMaximumTwoFlavors() {
        var myPizza = Pizza(crust: PizzaCrust(type: .cheeseBurst, size: .large))

        XCTAssert(myPizza.add(flavor: .crispCapsicum))
        XCTAssert(myPizza.add(flavor: .goldenCorn))
        XCTAssertFalse(myPizza.add(flavor: .bacon))
    }

    func testPizzaPrice() {
        var myPizza = Pizza(crust: PizzaCrust(type: .cheeseBurst, size: .large))
        _ = myPizza.add(flavor: .crispCapsicum)
        _ = myPizza.add(flavor: .onions)

        XCTAssert(myPizza.totalPrice() == 55.5)
    }

    func testPizzaTitle() {
        var myPizza = Pizza(crust: PizzaCrust(type: .cheeseBurst, size: .large))
        myPizza.crust.type = .cheeseBurst
        myPizza.crust.size = .large
        _ = myPizza.add(flavor: .crispCapsicum)
        _ = myPizza.add(flavor: .onions)

        let expectedName = "Large Cheese Burst Pizza with Crisp Capsicum, Onions"
        XCTAssert(myPizza.name() == expectedName)
    }

    func testAllFlavors() {
        let flavors = PizzaFlavor.allCases
        XCTAssert(flavors.count == 9)
    }

    func testPizzaOrderWithLessFlavors() {
        var myPizza = Pizza(crust: PizzaCrust(type: .cheeseBurst, size: .large))

        OrderManager.shared.finalizeOrder(pizza: myPizza) { (result) in
            switch result {
            case .success:
                XCTAssert(false)
            case .failure:
                XCTAssert(true)
            }
        }

        _ = myPizza.add(flavor: .bacon)
        OrderManager.shared.finalizeOrder(pizza: myPizza) { (result) in
            switch result {
            case .success:
                XCTAssert(false)
            case .failure:
                XCTAssert(true)
            }
        }

        _ = myPizza.add(flavor: .blackOlives)
        OrderManager.shared.finalizeOrder(pizza: myPizza) { (result) in
            switch result {
            case .success:
                XCTAssert(true)
            case .failure:
                XCTAssert(false)
            }
        }
    }
}
