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
    
    var lastEnterCommand = ActionType.None {
        didSet {
            // Avoid entering new math command if we have error
            if let calculationError = self.calculationError , calculationError != NSDecimalNumber.CalculationError.noError {
                lastEnterCommand = ActionType.None
            }
        }
    }
    var calculationError: NSDecimalNumber.CalculationError?
    
    fileprivate(set) internal var secondEnteredValue: NSDecimalNumber?
    fileprivate(set) internal var result = NSDecimalNumber.zero
    
    fileprivate override init() {
        
        
        
        
        
        
    }
    
    internal func reset() {
        self.lastEnterCommand = ActionType.None
        self.calculationError = nil
        self.result = NSDecimalNumber.zero
        self.secondEnteredValue = nil
    }
    
    func add(_ firstValue: NSDecimalNumber?, secondValue: NSDecimalNumber?) -> NSDecimalNumber {
        return executeMathOperation(firstValue, secondValue: secondValue, operation: NSDecimalAdd)
    }
    
    func subtracting(_ firstValue: NSDecimalNumber?, secondValue: NSDecimalNumber?) -> NSDecimalNumber {
        return executeMathOperation(firstValue, secondValue: secondValue, operation: NSDecimalSubtract)
    }
    
    func multiplying(_ firstValue: NSDecimalNumber?, secondValue: NSDecimalNumber?) -> NSDecimalNumber {
        return executeMathOperation(firstValue, secondValue: secondValue, operation: NSDecimalMultiply)
    }
    
    func dividing(_ firstValue: NSDecimalNumber?, secondValue: NSDecimalNumber?) -> NSDecimalNumber {
        return executeMathOperation(firstValue, secondValue: secondValue, operation: NSDecimalDivide)
    }
    
    func executeMathOperation(_ firstValue: NSDecimalNumber?, secondValue: NSDecimalNumber?, operation: (UnsafeMutablePointer<Decimal>, UnsafePointer<Decimal>, UnsafePointer<Decimal>, NSDecimalNumber.RoundingMode) -> NSDecimalNumber.CalculationError) -> NSDecimalNumber {
        var result = NSDecimalNumber.zero
        
        // Check if first parameter is exist
        if let firstValue = firstValue {
            // Check if second parameter is exist
            if let secondValue = secondValue {
                // Convert NSDecimalNumber's to NSDecimal
                var first = firstValue.decimalValue
                var second = secondValue.decimalValue
                var decimalReuslt = self.result.decimalValue
                
                // Try to execute command and check error status
                self.calculationError = operation(&decimalReuslt, &first, &second, NSDecimalNumber.RoundingMode.plain)
                
                if let calculationError = self.calculationError {
                    switch calculationError {
                    case NSDecimalNumber.CalculationError.noError:
                        self.secondEnteredValue = NSDecimalNumber.zero
                        self.lastEnterCommand = ActionType.None
                        
                        result = NSDecimalNumber(decimal: decimalReuslt)
                        break;
                        
                    default:
                        self.result = NSDecimalNumber.zero
                        break;
                    }
                }
            }
        }
        
        return result
    }
    
    func calculate() {
        switch self.lastEnterCommand {
        case ActionType.Add:
            self.result = self.add(self.result, secondValue: self.secondEnteredValue)
            break
            
        case ActionType.Subtracting:
            self.result = self.subtracting(self.result, secondValue: self.secondEnteredValue)
            break
            
        case ActionType.Multiplying:
            let tmpResult = self.multiplying(self.result, secondValue: self.secondEnteredValue)
            if let calculationError = self.calculationError , calculationError == NSDecimalNumber.CalculationError.noError {
                self.result = tmpResult
            }
            
            break
            
        case ActionType.Dividing:
            self.result = self.dividing(self.result, secondValue: self.secondEnteredValue)
            break
            
        default:
            break;
        }
        
        self.secondEnteredValue = nil
        self.lastEnterCommand = ActionType.None
    }
    
    func appendValue(_ value: String?) {
        if let value = value {
            var resultStr = ""
            if self.lastEnterCommand == ActionType.None {
                resultStr = self.result.stringValue
                self.calculationError = nil
            }
            else {
                if let calculationError = self.calculationError , calculationError != NSDecimalNumber.CalculationError.noError{
                    self.lastEnterCommand = ActionType.None;
                    self.secondEnteredValue = nil;
                }
                
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
        
        if let calculationError = self.calculationError , calculationError != NSDecimalNumber.CalculationError.noError {
            result = "Error"
        }
        else if self.lastEnterCommand == ActionType.None {
            result = CalculatorManager.shareInstance.result.stringValue
        }
        else {
            if let secondEnteredValue = self.secondEnteredValue {
                result = secondEnteredValue.stringValue
            }
        }
        
        return result
    }
}
