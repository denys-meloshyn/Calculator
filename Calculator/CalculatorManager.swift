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
            if let calculationError = self.calculationError where calculationError != NSCalculationError.NoError {
                lastEnterCommand = ActionType.None
            }
        }
    }
    var calculationError: NSCalculationError?
    
    private(set) internal var secondEnteredValue: NSDecimalNumber?
    private(set) internal var result = NSDecimalNumber.zero()
    
    private override init() {
    }
    
    func add(firstValue: NSDecimalNumber?, secondValue: NSDecimalNumber?) -> NSDecimalNumber {
        var result = NSDecimalNumber.zero()
        
        if let firstValue = firstValue {
            if let secondValue = secondValue {
                var first = firstValue.decimalValue
                var second = secondValue.decimalValue
                var decimalReuslt = self.result.decimalValue
                
                self.calculationError = NSDecimalAdd(&decimalReuslt, &first, &second, NSRoundingMode.RoundPlain)
                
                if let calculationError = self.calculationError {
                    switch calculationError {
                    case NSCalculationError.NoError:
                        self.result = NSDecimalNumber.zero()
                        self.secondEnteredValue = NSDecimalNumber.zero()
                        self.lastEnterCommand = ActionType.None
                        
                        result = firstValue.decimalNumberByAdding(secondValue)
                        break;
                    default:
                        break;
                    }
                }
            }
            else {
                result = firstValue.decimalNumberByAdding(result)
            }
        }
        
        return result
    }
    
    func subtracting(firstValue: NSDecimalNumber?, secondValue: NSDecimalNumber?) -> NSDecimalNumber {
        var result = NSDecimalNumber.zero()
        
        if let firstValue = firstValue {
            if let secondValue = secondValue {
                var first = firstValue.decimalValue
                var second = secondValue.decimalValue
                var decimalReuslt = self.result.decimalValue
                
                self.calculationError = NSDecimalSubtract(&decimalReuslt, &first, &second, NSRoundingMode.RoundPlain)
                
                if let calculationError = self.calculationError {
                    switch calculationError {
                    case NSCalculationError.NoError:
                        self.result = NSDecimalNumber.zero()
                        self.secondEnteredValue = NSDecimalNumber.zero()
                        self.lastEnterCommand = ActionType.None
                        
                        result = firstValue.decimalNumberBySubtracting(secondValue)
                        break;
                    default:
                        break;
                    }
                }
            }
            else {
                result = firstValue.decimalNumberBySubtracting(result)
            }
        }
        
        return result
    }
    
    func multiplying(firstValue: NSDecimalNumber?, secondValue: NSDecimalNumber?) -> NSDecimalNumber {
        var result = NSDecimalNumber.zero()
        
        if let firstValue = firstValue {
            if let secondValue = secondValue {
                var first = firstValue.decimalValue
                var second = secondValue.decimalValue
                var decimalReuslt = self.result.decimalValue
                
                self.calculationError = NSDecimalMultiply(&decimalReuslt, &first, &second, NSRoundingMode.RoundPlain)
                
                if let calculationError = self.calculationError {
                    switch calculationError {
                    case NSCalculationError.NoError:
                        self.result = NSDecimalNumber.zero()
                        self.secondEnteredValue = NSDecimalNumber.zero()
                        self.lastEnterCommand = ActionType.None
                        
                        result = firstValue.decimalNumberByMultiplyingBy(secondValue)
                        break;
                    default:
                        break;
                    }
                }
            }
            else {
                result = firstValue.decimalNumberByMultiplyingBy(result)
            }
        }
        
        return result
    }
    
    func dividing(firstValue: NSDecimalNumber?, secondValue: NSDecimalNumber?) -> NSDecimalNumber {
        var result = NSDecimalNumber.zero()
        
        if let firstValue = firstValue {
            if let secondValue = secondValue {
                var first = firstValue.decimalValue
                var second = secondValue.decimalValue
                var decimalReuslt = self.result.decimalValue
                
                self.calculationError = NSDecimalDivide(&decimalReuslt, &first, &second, NSRoundingMode.RoundPlain)
                
                if let calculationError = self.calculationError {
                    switch calculationError {
                    case NSCalculationError.NoError:
                        self.result = NSDecimalNumber.zero()
                        self.secondEnteredValue = NSDecimalNumber.zero()
                        self.lastEnterCommand = ActionType.None
                        
                        result = firstValue.decimalNumberByDividingBy(secondValue)
                        break;
                    default:
                        break;
                    }
                }
            }
            else {
                return NSDecimalNumber(int: 1)
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
            if let calculationError = self.calculationError where calculationError == NSCalculationError.NoError {
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
    
    func appendValue(value: String?) {
        if let value = value {
            var resultStr = ""
            if self.lastEnterCommand == ActionType.None {
                resultStr = self.result.stringValue
                self.calculationError = nil
            }
            else {
                if let calculationError = self.calculationError where calculationError != NSCalculationError.NoError{
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
        
        if let calculationError = self.calculationError where calculationError != NSCalculationError.NoError {
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
