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
        if sender.type == ActionType.Value {
            CalculatorManager.shareInstance.appendValue(sender.titleLabel?.text)
        }
        else  {
            CalculatorManager.shareInstance.lastEnterCommand = sender.type
        }
        
        self.updateCalculatorLabel()
    }
    
    func updateCalculatorLabel() {
        let formatter = CalculatorManager.shareInstance.numberFormatter()
        
        if CalculatorManager.shareInstance.lastEnterCommand == ActionType.None {
            self.calculatorResultLabel?.text = CalculatorManager.shareInstance.result.stringValue
        } else {
            self.calculatorResultLabel?.text = formatter.stringFromNumber(CalculatorManager.shareInstance.secondEnteredValue)
        }
    }
}

