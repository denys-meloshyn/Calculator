//
//  CalculatorTests.swift
//  CalculatorTests
//
//  Created by Denys.Meloshyn on 14/06/16.
//  Copyright © 2016 Denys Meloshyn. All rights reserved.
//

import XCTest
@testable import Calculator

class CalculatorTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAdd() {
        CalculatorManager.shareInstance.reset()
        
        let a = NSDecimalNumber(integer: 2)
        let b = NSDecimalNumber(integer: 3)
        let c = NSDecimalNumber(integer: 5)
        
        let result = CalculatorManager.shareInstance.add(a, secondValue: b)
        
        XCTAssertEqual(c, result)
    }
    
    func testSubtracting() {
        CalculatorManager.shareInstance.reset()
        
        let a = NSDecimalNumber(integer: 2)
        let b = NSDecimalNumber(integer: 3)
        let c = NSDecimalNumber(integer: -1)
        
        let result = CalculatorManager.shareInstance.subtracting(a, secondValue: b)
        
        XCTAssertEqual(c, result)
    }
    
    func testMultiplying() {
        CalculatorManager.shareInstance.reset()
        
        let a = NSDecimalNumber(integer: 2)
        let b = NSDecimalNumber(integer: 3)
        let c = NSDecimalNumber(integer: 6)
        
        let result = CalculatorManager.shareInstance.multiplying(a, secondValue: b)
        
        XCTAssertEqual(c, result)
    }
    
    func testDividing() {
        CalculatorManager.shareInstance.reset()
        
        let a = NSDecimalNumber(integer: 6)
        let b = NSDecimalNumber(integer: 3)
        let c = NSDecimalNumber(integer: 2)
        
        let result = CalculatorManager.shareInstance.dividing(a, secondValue: b)
        
        XCTAssertEqual(c, result)
    }
    
    func testDividingByZero() {
        CalculatorManager.shareInstance.reset()
        
        let a = NSDecimalNumber(integer: 6)
        let b = NSDecimalNumber(integer: 0)
        
        CalculatorManager.shareInstance.dividing(a, secondValue: b)
        
        XCTAssertNotEqual(CalculatorManager.shareInstance.calculationError, NSCalculationError.NoError)
    }
}
