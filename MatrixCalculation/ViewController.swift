//
//  ViewController.swift
//  MatrixCalculation
//
//  Created by Ragunath Rajagopal on 21/02/17.
//  Copyright © 2017 Ragunath Rajagopal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textViewNumber: UITextView!
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textViewNumber.text = " Eg Input:\n 1 2 3\n 2 4 5\n 4 5 2"
        textViewNumber.textColor = UIColor.lightGray
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UITextView Delegate
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = " Eg Input:\n 1 2 3\n 2 4 5\n 4 5 2"
            textView.textColor = UIColor.lightGray
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        return true
    }
    
    // MARK: Button Action
    
    @IBAction func actionCalculate(sender: UIButton) {
        
        if !validateMatrix(number: textViewNumber.text) {
            
            let alert = UIAlertController(title: "Invalid matrix", message: "All rows must have the same length", preferredStyle: UIAlertControllerStyle.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
            
        } else {
            
            let parser = InputParser()
            let grid = parser.parse(textViewNumber.text)
            let finder = PathFinder()
            let result = finder.find(grid)
            show(result)
        }
        
        
        
    }
    
    // MARK: Custom  Action
    
    private func show(_ result: (Bool, Int, Array<Int>)) {
        let (success, resistance, path) = result
        
        var message = success ? "Yes" : "No"
        message += "\n" + String(resistance)
        message += "\n" + path.map(){x in String(x)}.joined(separator: " ")
        
        // create the alert

        let trimmedString = textViewNumber.text.trimmingCharacters(in: .whitespaces)
        let letters = NSCharacterSet.letters
        
        let phrase = textViewNumber.text
        let range = phrase?.rangeOfCharacter(from: letters)

        if trimmedString.isEmpty {
            
           message="Invalid matrix"
                
        } else if range != nil {
            
            message="Invalid matrix"
        }

 
        // create the alert
        let alert = UIAlertController(title: "Result", message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    // Validates the Input
    
    private func validateMatrix(number: String) -> Bool {
        
        var length: Int!
        let numberofRows = number.components(separatedBy: "\n")
        for row in numberofRows {
            let items = row.components(separatedBy: " ")
            
            if length == nil {
                length = items.count
            }
            if items.count != length {
                return false
            }
        }
        return length != nil
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       textViewNumber .resignFirstResponder()
    }
    
}

