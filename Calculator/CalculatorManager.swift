//
//  CalculatorManager.swift
//  Calculator
//
//  Created by Denys.Meloshyn on 14/06/16.
//  Copyright © 2016 Denys Meloshyn. All rights reserved.
//

import UIKit

class CalculatorManager: NSObject {
    static let shareInstance = CalculatorManager()
    
    var lastEnterCommand = ActionType.None
    
    private(set) internal var secondEnteredValue = NSDecimalNumber.zero()
    private(set) internal var result = NSDecimalNumber.zero()
    
    func numberFormatter() -> NSNumberFormatter {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        formatter.formatterBehavior = NSNumberFormatterBehavior.BehaviorDefault
        formatter.generatesDecimalNumbers = true
//        formatter.minimumIntegerDigits = 1
        
        return formatter
    }
    
    private override init() {
    }
    
    func add<T: Comparable>(x: T) {
        
    }
    
    func appendValue(value: String?) {
        if let value = value {
            let formatter = self.numberFormatter()
            
            if value == formatter.decimalSeparator {
//                if self.lastEnterCommand == ActionType.None {
//                    self.result = self.result.decimalNumberByMultiplyingBy(NSDecimalNumber(string: "1.0"))
//                }
//                else {
//                    self.secondEnteredValue = self.secondEnteredValue.decimalNumberByMultiplyingBy(NSDecimalNumber(string: "1.0"), withBehavior: nil)
//                }
            }
            
            var resultStr = ""
            if self.lastEnterCommand == ActionType.None {
                if let result = formatter.stringFromNumber(self.result) {
                    resultStr = self.result.stringValue + ".0"
                }
            }
            else {
                if let result = formatter.stringFromNumber(self.secondEnteredValue) {
                    resultStr = result;
                }
            }
            resultStr += value
            
            if self.lastEnterCommand == ActionType.None {
                self.result = NSDecimalNumber(string: resultStr);
            }
            else {
                self.secondEnteredValue = NSDecimalNumber(string: resultStr);
            }
        }
    }
    
    private func resultToString() -> String? {
        let formatter = self.numberFormatter()
        
        return formatter.stringFromNumber(self.result)
    }
}
