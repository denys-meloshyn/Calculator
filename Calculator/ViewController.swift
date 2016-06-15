//
//  ViewController.swift
//  Calculator
//
//  Created by Denys.Meloshyn on 14/06/16.
//  Copyright © 2016 Denys Meloshyn. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CalculatorButtonDelegate {
    @IBOutlet private var calculatorResultLabel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Orientation methods
    
    override func shouldAutorotate () -> (Bool) {
        return true
    }
    
    override func supportedInterfaceOrientations () -> (UIInterfaceOrientationMask) {
        return UIInterfaceOrientationMask.Portrait
    }
    
    override func preferredInterfaceOrientationForPresentation () -> (UIInterfaceOrientation) {
        return UIInterfaceOrientation.Portrait
    }

    func action(sender: CalculatorButtonView) {
        switch sender.type {
        case ActionType.Value:
            CalculatorManager.shareInstance.appendValue(sender.titleLabel?.text)
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
        
        self.updateCalculatorLabel()
    }
    
    func updateCalculatorLabel() {
        self.calculatorResultLabel?.text = CalculatorManager.shareInstance.string()
    }
}

