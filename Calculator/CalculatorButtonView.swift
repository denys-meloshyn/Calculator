//
//  CalculatorButtonView.swift
//  Calculator
//
//  Created by Denys Meloshyn on 14.06.16.
//  Copyright © 2016 Denys Meloshyn. All rights reserved.
//

import UIKit

enum ActionType: String {
    case None = "none"
    case Value = "value"
    case Add = "add"
    case Subtracting = "subtracting"
    case Multiplying = "multiplying"
    case Dividing = "dividing"
    case Calculate = "calculate"
};

@objc public protocol CalculatorButtonDelegate {
    func action(_ sender: CalculatorButtonView)
}

open class CalculatorButtonView: UIView {
    @IBOutlet var titleLabel: UILabel?
    @IBOutlet weak var delegate: CalculatorButtonDelegate?
    
    var type = ActionType.Value
    
    @IBInspectable var buttonType: String = "" {
        willSet {
            if let newValue = ActionType(rawValue: newValue.lowercased() ) {
                self.type = newValue
            }
        }
    }
    
    @IBAction fileprivate func sendAction(_ sender: UIButton) {
        self.delegate?.action(self)
    }
}
