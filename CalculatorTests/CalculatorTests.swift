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
    
    func testAddNegative() {
        CalculatorManager.shareInstance.reset()
        
        let a = NSDecimalNumber(integer: -2)
        let b = NSDecimalNumber(integer: -3)
        let c = NSDecimalNumber(integer: -5)
        
        let result = CalculatorManager.shareInstance.add(a, secondValue: b)
        
        XCTAssertEqual(c, result)
    }
    
    func testAddToMaxNumber() {
        CalculatorManager.shareInstance.reset()
        
        let a = NSDecimalNumber.maximumDecimalNumber()
        let b = NSDecimalNumber(integer: 1)
        
        CalculatorManager.shareInstance.add(a, secondValue: b)
        XCTAssertNotEqual(CalculatorManager.shareInstance.calculationError, NSCalculationError.NoError)
    }
    
    func testSubtracting() {
        CalculatorManager.shareInstance.reset()
        
        let a = NSDecimalNumber(integer: 2)
        let b = NSDecimalNumber(integer: 3)
        let c = NSDecimalNumber(integer: -1)
        
        let result = CalculatorManager.shareInstance.subtracting(a, secondValue: b)
        
        XCTAssertEqual(c, result)
    }
    
    func testSubtractingNegative() {
        CalculatorManager.shareInstance.reset()
        
        let a = NSDecimalNumber(integer: -2)
        let b = NSDecimalNumber(integer: -3)
        let c = NSDecimalNumber(integer: 1)
        
        let result = CalculatorManager.shareInstance.subtracting(a, secondValue: b)
        
        XCTAssertEqual(c, result)
    }
    
    func testSubtractingMinimum() {
        CalculatorManager.shareInstance.reset()
        
        let a = NSDecimalNumber.minimumDecimalNumber()
        let b = NSDecimalNumber(integer: 1)
        
        CalculatorManager.shareInstance.subtracting(a, secondValue: b)
        XCTAssertNotEqual(CalculatorManager.shareInstance.calculationError, NSCalculationError.NoError)
    }
    
    func testMultiplying() {
        CalculatorManager.shareInstance.reset()
        
        let a = NSDecimalNumber(integer: 2)
        let b = NSDecimalNumber(integer: 3)
        let c = NSDecimalNumber(integer: 6)
        
        let result = CalculatorManager.shareInstance.multiplying(a, secondValue: b)
        
        XCTAssertEqual(c, result)
    }
    
    func testMultiplyingNegative() {
        CalculatorManager.shareInstance.reset()
        
        let a = NSDecimalNumber(integer: -2)
        let b = NSDecimalNumber(integer: -3)
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
    
    func testDividingNegative() {
        CalculatorManager.shareInstance.reset()
        
        let a = NSDecimalNumber(integer: -6)
        let b = NSDecimalNumber(integer: -3)
        let c = NSDecimalNumber(integer: 2)
        
        let result = CalculatorManager.shareInstance.dividing(a, secondValue: b)
        
        XCTAssertEqual(c, result)
    }
    
    func testDividingZeroByNumber() {
        CalculatorManager.shareInstance.reset()
        
        let a = NSDecimalNumber(integer: 0)
        let b = NSDecimalNumber(integer: 6)
        let c = NSDecimalNumber(integer: 0)
        
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
    
    func testDividingMixedOperations() {
        CalculatorManager.shareInstance.reset()
        
        var a = NSDecimalNumber(integer: 6)
        let b = NSDecimalNumber(integer: 100)
        var c = NSDecimalNumber.zero()
        c = CalculatorManager.shareInstance.add(a, secondValue: b)
        
        a = NSDecimalNumber(integer: -200)
        c = CalculatorManager.shareInstance.add(c, secondValue: a)
        
        a = NSDecimalNumber(integer: -2)
        c = CalculatorManager.shareInstance.dividing(c, secondValue: a)
        
        a = NSDecimalNumber(double: 100.5)
        c = CalculatorManager.shareInstance.multiplying(c, secondValue: a)
        
        let result = NSDecimalNumber(double: 4723.5)
        
        XCTAssertEqual(c, result)
    }

}
