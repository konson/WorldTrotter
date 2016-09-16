//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by Alecsandra Konson on 9/8/16.
//  Copyright © 2016 Apperator. All rights reserved.
// 


import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var celsiusLabel: UILabel!
    @IBOutlet var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
         // change background color randomly
        let color = UIColor(red: CGFloat(Double(arc4random_uniform(101)) / 100.0),
                            green: CGFloat(Double(arc4random_uniform(101)) / 100.0),
                            blue: CGFloat(Double(arc4random_uniform(101)) / 100.0),
                            alpha: 1.0)
       view.backgroundColor = color
    }

    
    @IBAction func fahrenheitFieldEditingChanged(textField: UITextField) {
        
        if let text = textField.text, let number = numberFormatter.number(from: text) {
            fahrenheitValue = number.doubleValue
        } else {
            fahrenheitValue = nil
        }
    }
    
    var fahrenheitValue: Double? {
        // property observer - gets called whenever a property's value changes
        didSet {
            updateCelsiusLabel()
        }
    }
    
    func updateCelsiusLabel() {
        if let value = celsiusValue {
            celsiusLabel.text = numberFormatter.string(for: value)
        }
        else {
            celsiusLabel.text = "???"
        }
    }
    
    var celsiusValue: Double? {
        if let value = fahrenheitValue {
            return (value - 32) * (5/9)
        }
        else {
            return nil
        }
    }
    
    // create a constant number formatter
    // uses a CLOSURE!!
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    // already declared UITextFieldDelegate protocal at class declaration and
    // to set delegate property on text field: 
    // ctrl-dragged from value textField to conversion view controller and selected "delegate"
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentLocale = NSLocale.current
        let decimalSeparator = currentLocale.decimalSeparator! as String
        
        let existingTextHasDecimalSeparator = textField.text?.range(of: decimalSeparator)
        let replacementTextHasDecimalSeparator = string.range(of: decimalSeparator)
        
            if existingTextHasDecimalSeparator != nil &&
                replacementTextHasDecimalSeparator != nil {
                    return false
            }
                else {
                    return true
            }
        }
    

    @IBAction func dismissKeyboard(sender: AnyObject) {
        textField.resignFirstResponder()
    }

    
}
