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
        
        let a = NSDecimalNumber(value: 2 as Int)
        let b = NSDecimalNumber(value: 3 as Int)
        let c = NSDecimalNumber(value: 5 as Int)
        
        let result = CalculatorManager.shareInstance.add(a, secondValue: b)
        
        XCTAssertEqual(c, result)
    }
    
    func testAddNegative() {
        CalculatorManager.shareInstance.reset()
        
        let a = NSDecimalNumber(value: -2 as Int)
        let b = NSDecimalNumber(value: -3 as Int)
        let c = NSDecimalNumber(value: -5 as Int)
        
        let result = CalculatorManager.shareInstance.add(a, secondValue: b)
        
        XCTAssertEqual(c, result)
    }
    
    func testAddToMaxNumber() {
        CalculatorManager.shareInstance.reset()
        
        let a = NSDecimalNumber.maximum
        let b = NSDecimalNumber(value: 1 as Int)
        
        CalculatorManager.shareInstance.add(a, secondValue: b)
        XCTAssertNotEqual(CalculatorManager.shareInstance.calculationError, NSDecimalNumber.CalculationError.noError)
    }
    
    func testSubtracting() {
        CalculatorManager.shareInstance.reset()
        
        let a = NSDecimalNumber(value: 2 as Int)
        let b = NSDecimalNumber(value: 3 as Int)
        let c = NSDecimalNumber(value: -1 as Int)
        
        let result = CalculatorManager.shareInstance.subtracting(a, secondValue: b)
        
        XCTAssertEqual(c, result)
    }
    
    func testSubtractingNegative() {
        CalculatorManager.shareInstance.reset()
        
        let a = NSDecimalNumber(value: -2 as Int)
        let b = NSDecimalNumber(value: -3 as Int)
        let c = NSDecimalNumber(value: 1 as Int)
        
        let result = CalculatorManager.shareInstance.subtracting(a, secondValue: b)
        
        XCTAssertEqual(c, result)
    }
    
    func testSubtractingMinimum() {
        CalculatorManager.shareInstance.reset()
        
        let a = NSDecimalNumber.minimum
        let b = NSDecimalNumber(value: 1 as Int)
        
        CalculatorManager.shareInstance.subtracting(a, secondValue: b)
        XCTAssertNotEqual(CalculatorManager.shareInstance.calculationError, NSDecimalNumber.CalculationError.noError)
    }
    
    func testMultiplying() {
        CalculatorManager.shareInstance.reset()
        
        let a = NSDecimalNumber(value: 2 as Int)
        let b = NSDecimalNumber(value: 3 as Int)
        let c = NSDecimalNumber(value: 6 as Int)
        
        let result = CalculatorManager.shareInstance.multiplying(a, secondValue: b)
        
        XCTAssertEqual(c, result)
    }
    
    func testMultiplyingNegative() {
        CalculatorManager.shareInstance.reset()
        
        let a = NSDecimalNumber(value: -2 as Int)
        let b = NSDecimalNumber(value: -3 as Int)
        let c = NSDecimalNumber(value: 6 as Int)
        
        let result = CalculatorManager.shareInstance.multiplying(a, secondValue: b)
        
        XCTAssertEqual(c, result)
    }
    
    func testDividing() {
        CalculatorManager.shareInstance.reset()
        
        let a = NSDecimalNumber(value: 6 as Int)
        let b = NSDecimalNumber(value: 3 as Int)
        let c = NSDecimalNumber(value: 2 as Int)
        
        let result = CalculatorManager.shareInstance.dividing(a, secondValue: b)
        
        XCTAssertEqual(c, result)
    }
    
    func testDividingNegative() {
        CalculatorManager.shareInstance.reset()
        
        let a = NSDecimalNumber(value: -6 as Int)
        let b = NSDecimalNumber(value: -3 as Int)
        let c = NSDecimalNumber(value: 2 as Int)
        
        let result = CalculatorManager.shareInstance.dividing(a, secondValue: b)
        
        XCTAssertEqual(c, result)
    }
    
    func testDividingZeroByNumber() {
        CalculatorManager.shareInstance.reset()
        
        let a = NSDecimalNumber(value: 0 as Int)
        let b = NSDecimalNumber(value: 6 as Int)
        let c = NSDecimalNumber(value: 0 as Int)
        
        let result = CalculatorManager.shareInstance.dividing(a, secondValue: b)
        
        XCTAssertEqual(c, result)
    }
    
    func testDividingByZero() {
        CalculatorManager.shareInstance.reset()
        
        let a = NSDecimalNumber(value: 6 as Int)
        let b = NSDecimalNumber(value: 0 as Int)
        
        CalculatorManager.shareInstance.dividing(a, secondValue: b)
        
        XCTAssertNotEqual(CalculatorManager.shareInstance.calculationError, NSDecimalNumber.CalculationError.noError)
    }
    
    func testDividingMixedOperations() {
        CalculatorManager.shareInstance.reset()
        
        var a = NSDecimalNumber(value: 6 as Int)
        let b = NSDecimalNumber(value: 100 as Int)
        var c = NSDecimalNumber.zero
        c = CalculatorManager.shareInstance.add(a, secondValue: b)
        
        a = NSDecimalNumber(value: -200 as Int)
        c = CalculatorManager.shareInstance.add(c, secondValue: a)
        
        a = NSDecimalNumber(value: -2 as Int)
        c = CalculatorManager.shareInstance.dividing(c, secondValue: a)
        
        a = NSDecimalNumber(value: 100.5 as Double)
        c = CalculatorManager.shareInstance.multiplying(c, secondValue: a)
        
        let result = NSDecimalNumber(value: 4723.5 as Double)
        
        XCTAssertEqual(c, result)
    }

}
