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
    
    private(set) internal var secondEnteredValue: NSDecimalNumber?
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
    
    func add(firstValue: NSDecimalNumber?, secondValue: NSDecimalNumber?) -> NSDecimalNumber {
        var result = NSDecimalNumber.zero()
        
        if let firstValue = firstValue {
            if let secondValue = secondValue {
                result = firstValue.decimalNumberByAdding(secondValue)
            }
            else {
                result = firstValue.decimalNumberByAdding(result)
            }
        }
        
        return result
    }
    
    func calculate() {
        switch self.lastEnterCommand {
        case ActionType.Add:
            self.result = self.add(self.result, secondValue: self.secondEnteredValue)
            self.secondEnteredValue = nil
            break
        default:
            break;
        }
        
        self.lastEnterCommand = ActionType.None
    }
    
    func appendValue(value: String?) {
        if let value = value {
            
            var resultStr = ""
            if self.lastEnterCommand == ActionType.None {
                resultStr = self.result.stringValue
            }
            else {
                if let secondEnteredValue = self.secondEnteredValue {
                    resultStr = secondEnteredValue.stringValue
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
    
    func string() -> String {
        var result = "0"
        
        if self.lastEnterCommand == ActionType.None {
            result = CalculatorManager.shareInstance.result.stringValue
        } else {
            if let secondEnteredValue = self.secondEnteredValue {
                result = secondEnteredValue.stringValue
            }
        }
        
        return result
    }
    
    private func resultToString() -> String? {
        let formatter = self.numberFormatter()
        
        return formatter.stringFromNumber(self.result)
    }
}
