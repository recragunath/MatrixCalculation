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
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UITextView Delegate
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        return true
    }
    
    // MARK: Button Action
    
    @IBAction func actionCalculate(sender: UIButton) {
        let parser = InputParser()
        let grid = parser.parse(textViewNumber.text)
        let finder = PathFinder()
        let result = finder.find(grid)
        show(result)
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       textViewNumber .resignFirstResponder()
    }
    
}

