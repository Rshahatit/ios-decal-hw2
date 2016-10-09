//
//  ViewController.swift
//  SwiftCalc
//
//  Created by Zach Zeleznick on 9/20/16.
//  Copyright © 2016 zzeleznick. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK: Width and Height of Screen for Layout
    var w: CGFloat!
    var h: CGFloat!
    

    // IMPORTANT: Do NOT modify the name or class of resultLabel.
    //            We will be using the result label to run autograded tests.
    // MARK: The label to display our calculations
    var resultLabel = UILabel()
    
    // TODO: This looks like a good place to add some data structures.
    //       One data structure is initialized below for reference.

    //var numbers = ["0"]
    var result = "0"
    //var numbers2 = ["0"]
    var result2 = "0"
    var op = ""
    var decimal = false
    var opPressed = false
    var error = false
    let ops = ["/", "*", "-", "+"]

    override func viewDidLoad() {
        super.viewDidLoad()
        view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
        w = view.bounds.size.width
        h = view.bounds.size.height
        navigationItem.title = "Calculator"
        // IMPORTANT: Do NOT modify the accessibilityValue of resultLabel.
        //            We will be using the result label to run autograded tests.
        resultLabel.accessibilityValue = "resultLabel"
        makeButtons()
        // Do any additional setup here.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // TODO: A method to update your data structure(s) would be nice.
    //       Modify this one or create your own.
    func updateSomeDataStructure(_ content: String) {
        if (!opPressed) {
            result.append(content)
        } else if (opPressed) {
            result2.append(content)
        }
        
    }
    
    // TODO: Ensure that resultLabel gets updated.
    //       Modify this one or create your own.
    func updateResultLabel(_ content: String) {
        resultLabel.text = content
    }
    
    
    // TODO: A calculate method with no parameters, scary!
    //       Modify this one or create your own.
    func calculate() -> String {
        return "0"
    }
    
    // TODO: A simple calculate method for integers.
    //       Modify this one or create your own.
    func intCalculate(a: Int, b:Int, operation: String) -> Int {
        print("Calculation requested for \(a) \(operation) \(b)")
        var answer = 0
        if (operation == "+") {
            answer = a + b
            print(answer)
        } else if (operation == "-") {
            answer = a - b
            print("-")
        } else if (operation == "*") {
            answer = a * b
            print("*")
        } else if (operation == "/") {
            print("a is \(a) and b is \(b)")
//            if (b == 0) {
//                error = true
//                result = "Not a number"
//            } else {
            print("/")
            answer = a / b
            //}
        }
        return answer
    }

    
    // TODO: A general calculate method for doubles
    //       Modify this one or create your own.
    func calculate(a: String, b:String, operation: String) -> Double {
        print("Calculation requested for \(a) \(operation) \(b)")
        return 0.0
    }
    
    // REQUIRED: The responder to a number button being pressed.
    func numberPressed(_ sender: CustomButton) {
        guard Int(sender.content) != nil else { return }
        if (!opPressed) {
            if (result.characters.count < 7) {
                if (result[result.startIndex] == "0" && !decimal) {
                    result = sender.content
                } else {
                    //updateSomeDataStructure(sender.content)
                    result.append(sender.content)
                }
            updateResultLabel(result)
            }
        } else if (opPressed) {
            if (result2.characters.count < 7) {
                if (result2[result2.startIndex] == "0" && !decimal) {
                    result2 = sender.content
                } else {
                    //updateSomeDataStructure(sender.content)
                    result2.append(sender.content)
                }
                updateResultLabel(result2)
                }
            }
        }
    
    // REQUIRED: The responder to an operator button being pressed.
    func operatorPressed(_ sender: CustomButton) {
        if ("C" == sender.content) {
            result = "0"
            result2 = "0"
            decimal = false
            opPressed = false
            updateResultLabel(result)
        } else if ("%" == sender.content && result.characters.count < 7) {
            if (result[result.startIndex] == "0" && result.characters.count == 1) {
                result = "0"
                updateResultLabel(result)
            } else {
                var number: Double
                number = Double(result)!
                number = number / 100
                if (!opPressed) {
                    result = String(number)
                } else if (opPressed) {
                    result2 = String(number)
                }
                updateResultLabel(result)
            }
            
        } else if ("+/-" == sender.content) {
            if (result[result.startIndex] != "-" && result.characters.count < 7) {
                if (result.characters.count == 1 && result[result.startIndex] == "0") {
                    //do nothing
                } else {
                    result.insert("-", at: result.startIndex)
                }
            } else if  (result[result.startIndex] == "-"){
                result.remove(at: result.startIndex)
            }
            updateResultLabel(result)
           
        } else if (ops.contains(sender.content)) {
            if (opPressed) {
//                if (error) {
//                    result2 = "0"
//                    op = ""
//                    error = false
//                } else {
                op = sender.content
                result = String(intCalculate(a: Int(result)!, b: Int(result2)!,operation: op))
                result2 = "0"
                //opPressed = false
               // }
            } else {
                op = sender.content
                opPressed = true
            }
        } else if ("=" == sender.content) {
            if (decimal) {
                    result = String(calculate(a: result, b: result2, operation:     op))
            } else if (!decimal) {
                result = String(intCalculate(a: Int(result)!, b: Int(result2)!, operation: op))
                result2 = "0"
                }
            opPressed = false
        }
        updateResultLabel(result)
    }
    
    // REQUIRED: The responder to a number or operator button being pressed.
    func buttonPressed(_ sender: CustomButton) {
        if (!opPressed) {
            if (result.characters.count < 7) {
                if ("." == sender.content && !decimal) {
                    decimal = true
                    updateSomeDataStructure(sender.content)
                }
                if (decimal && "0" == sender.content) {
                    updateSomeDataStructure(sender.content)
                } else if ("0" == sender.content && result[result.startIndex] != "0") {
                    updateSomeDataStructure(sender.content)
                }
                updateResultLabel(result)

            } else if (result2.characters.count < 7) {
                if ("." == sender.content && !decimal) {
                    decimal = true
                    updateSomeDataStructure(sender.content)
                }
                if (decimal && "0" == sender.content) {
                    updateSomeDataStructure(sender.content)
                } else if ("0" == sender.content && result[result.startIndex] != "0") {
                    updateSomeDataStructure(sender.content)
                }
                updateResultLabel(result2)
            }
        }
    }
    
    // IMPORTANT: Do NOT change any of the code below.
    //            We will be using these buttons to run autograded tests.
    
    func makeButtons() {
        // MARK: Adds buttons
        let digits = (1..<10).map({
            return String($0)
        })
        let operators = ["/", "*", "-", "+", "="]
        let others = ["C", "+/-", "%"]
        let special = ["0", "."]
        
        let displayContainer = UIView()
        view.addUIElement(displayContainer, frame: CGRect(x: 0, y: 0, width: w, height: 160)) { element in
            guard let container = element as? UIView else { return }
            container.backgroundColor = UIColor.black
        }
        displayContainer.addUIElement(resultLabel, text: "0", frame: CGRect(x: 70, y: 70, width: w-70, height: 90)) {
            element in
            guard let label = element as? UILabel else { return }
            label.textColor = UIColor.white
            label.font = UIFont(name: label.font.fontName, size: 60)
            label.textAlignment = NSTextAlignment.right
        }
        
        let calcContainer = UIView()
        view.addUIElement(calcContainer, frame: CGRect(x: 0, y: 160, width: w, height: h-160)) { element in
            guard let container = element as? UIView else { return }
            container.backgroundColor = UIColor.black
        }

        let margin: CGFloat = 1.0
        let buttonWidth: CGFloat = w / 4.0
        let buttonHeight: CGFloat = 100.0
        
        // MARK: Top Row
        for (i, el) in others.enumerated() {
            let x = (CGFloat(i%3) + 1.0) * margin + (CGFloat(i%3) * buttonWidth)
            let y = (CGFloat(i/3) + 1.0) * margin + (CGFloat(i/3) * buttonHeight)
            calcContainer.addUIElement(CustomButton(content: el), text: el,
            frame: CGRect(x: x, y: y, width: buttonWidth, height: buttonHeight)) { element in
                guard let button = element as? UIButton else { return }
                button.addTarget(self, action: #selector(operatorPressed), for: .touchUpInside)
            }
        }
        // MARK: Second Row 3x3
        for (i, digit) in digits.enumerated() {
            let x = (CGFloat(i%3) + 1.0) * margin + (CGFloat(i%3) * buttonWidth)
            let y = (CGFloat(i/3) + 1.0) * margin + (CGFloat(i/3) * buttonHeight)
            calcContainer.addUIElement(CustomButton(content: digit), text: digit,
            frame: CGRect(x: x, y: y+101.0, width: buttonWidth, height: buttonHeight)) { element in
                guard let button = element as? UIButton else { return }
                button.addTarget(self, action: #selector(numberPressed), for: .touchUpInside)
            }
        }
        // MARK: Vertical Column of Operators
        for (i, el) in operators.enumerated() {
            let x = (CGFloat(3) + 1.0) * margin + (CGFloat(3) * buttonWidth)
            let y = (CGFloat(i) + 1.0) * margin + (CGFloat(i) * buttonHeight)
            calcContainer.addUIElement(CustomButton(content: el), text: el,
            frame: CGRect(x: x, y: y, width: buttonWidth, height: buttonHeight)) { element in
                guard let button = element as? UIButton else { return }
                button.backgroundColor = UIColor.orange
                button.setTitleColor(UIColor.white, for: .normal)
                button.addTarget(self, action: #selector(operatorPressed), for: .touchUpInside)
            }
        }
        // MARK: Last Row for big 0 and .
        for (i, el) in special.enumerated() {
            let myWidth = buttonWidth * (CGFloat((i+1)%2) + 1.0) + margin * (CGFloat((i+1)%2))
            let x = (CGFloat(2*i) + 1.0) * margin + buttonWidth * (CGFloat(i*2))
            calcContainer.addUIElement(CustomButton(content: el), text: el,
            frame: CGRect(x: x, y: 405, width: myWidth, height: buttonHeight)) { element in
                guard let button = element as? UIButton else { return }
                button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
            }
        }
    }

}

