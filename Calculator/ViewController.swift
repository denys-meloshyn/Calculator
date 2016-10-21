//
//  ViewController.swift
//  Calculator
//
//  Created by Denys.Meloshyn on 14/06/16.
//  Copyright © 2016 Denys Meloshyn. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CalculatorButtonDelegate {
    @IBOutlet fileprivate var calculatorResultLabel: UILabel?
    
    // MARK: - Orientation methods
    
    override var shouldAutorotate  : (Bool) {
        return true
    }
    
    override var supportedInterfaceOrientations  : (UIInterfaceOrientationMask) {
        return UIInterfaceOrientationMask.portrait
    }
    
    override var preferredInterfaceOrientationForPresentation  : (UIInterfaceOrientation) {
        return UIInterfaceOrientation.portrait
    }
    
    // MARK: - CalculatorButtonDelegate methds
    
    func action(_ sender: CalculatorButtonView) {
        switch sender.type {
        case ActionType.Value:
            CalculatorManager.shareInstance.appendValue(sender.titleLabel?.text)
            self.updateCalculatorLabel()
            break
            
        case ActionType.Add, ActionType.Subtracting, ActionType.Multiplying, ActionType.Dividing:
            CalculatorManager.shareInstance.lastEnterCommand = sender.type
            break
            
        case ActionType.Calculate:
            CalculatorManager.shareInstance.calculate()
            self.updateCalculatorLabel()
            break
        default:
            break
        }
    }
    
    // MARK: - Private methods
    
    fileprivate func updateCalculatorLabel() {
        self.calculatorResultLabel?.text = CalculatorManager.shareInstance.string()
    }
    
    // MARK: - IBAction methods
    
    @IBAction func clear() {
        CalculatorManager.shareInstance.reset()
        self.updateCalculatorLabel()
    }
}

