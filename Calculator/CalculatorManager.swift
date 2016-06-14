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
    
    private(set) internal var result = NSNumber()
    
    func numberFormatter() -> NSNumberFormatter {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        formatter.minimumIntegerDigits = 1
        
        return formatter
    }
    
    private override init() {
    }
    
    func add<T: Comparable>(x: T) {
        
    }
    
    func appendValue(value: String) {
        let formatter = self.numberFormatter()
        if let resultStr = self.resultToString() {
            if value == formatter.decimalSeparator {
                if resultStr.containsString(formatter.decimalSeparator) {
                   return
                }
            }
            
        }
    }
    
    private func resultToString() -> String? {
        let formatter = self.numberFormatter()
        
        return formatter.stringFromNumber(self.result)
    }
}
