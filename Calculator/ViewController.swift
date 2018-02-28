import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    
    var brain = CalculatorBrain()
    
    var userIsCurrentlyTyping = false
    
    @IBAction func numberButtonPressed(_ sender: UIButton) {
        let buttonText = sender.currentTitle!
        let currentText = display.text!
        if userIsCurrentlyTyping {
            if (buttonText == ".") { return }
            display.text = currentText + buttonText
        } else {
            if buttonText == "." {
                display.text = "0."
            } else {
                display.text = buttonText
            }
            userIsCurrentlyTyping = true
        }
        /*
        if userIsCurrentlyTyping {
            let currentText = display.text!
            display.text = currentText + buttonText
        } else {
            display.text = buttonText
            userIsCurrentlyTyping = true
        }
 */
    }
    
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    
    }

    
    @IBAction func operationButtonPressed(_ sender: UIButton) {
        userIsCurrentlyTyping = false
        brain.setOperand(displayValue)
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(mathematicalSymbol)
        }
        if let result = brain.result {
            displayValue = result
        }
    }
    
    @IBAction func clearButton(_ sender: UIButton) {
        display.text = ""
        displayValue = 0.0
    }
    
    
}
