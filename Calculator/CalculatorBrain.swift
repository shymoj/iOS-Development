import Foundation

struct CalculatorBrain {
    
    var accumulator: Double?
    
    private var currentPendingBinaryOperation: PendingBinaryOperation?
    
    enum Operation {
        case constant(Double)
        case unaryOperation( (Double) -> Double )
        case binareOperation( (Double,Double) -> Double )
        case equals
        case clear
    }
    
    
    var operations: [String: Operation] = [
        "π": Operation.constant(Double.pi),
        "e": Operation.constant(M_E),
        "√": Operation.unaryOperation(sqrt),
        "cos": Operation.unaryOperation(cos),
        "sin": Operation.unaryOperation(sin),
        "tan": Operation.unaryOperation(tan),
        "log": Operation.unaryOperation(log),
        "x²": Operation.unaryOperation( {
            return $0 * $0
        }),
        "x³": Operation.unaryOperation( {
            return $0 * $0 * $0
        }),
        "±": Operation.unaryOperation( {
            return -($0)
        }),
        "csc": Operation.unaryOperation( {
            return 1/sin($0)
        }),
        "cot": Operation.unaryOperation( {
            return 1/tan($0)
        }),
        "sec": Operation.unaryOperation( {
            return 1/cos($0)
        }),
        "*": Operation.binareOperation({ $0 * $1 }),
        "+": Operation.binareOperation({ $0 + $1 }),
        "-": Operation.binareOperation({ $0 - $1 }),
        "/": Operation.binareOperation({ return ($0 / $1)}),
        "=": Operation.equals,
        "CLR": Operation.clear
    ]
    
    mutating func performOperation(_ mathematicalSymbol: String) {
        if let operation = operations[mathematicalSymbol] {
            switch operation {
            case Operation.constant(let value):
                accumulator = value
            case Operation.unaryOperation(let function):
                if let value = accumulator {
                    accumulator = function(value)
                }
            case .binareOperation(let function):
                if let firstOperand = accumulator {
                    currentPendingBinaryOperation = PendingBinaryOperation(firstOperand: firstOperand, function: function)
                    accumulator = nil
                }
            case .equals:
                perfomrBinaryOperation()
            
            case .clear:
               accumulator = clear
 
            }
 
        }
    }
    
    mutating func perfomrBinaryOperation() {
        if let operation = currentPendingBinaryOperation, let secondOperand = accumulator {
            accumulator = operation.perform(secondOperand: secondOperand)
        }
    }
    
    
    var clear: Double?{
        get{
            return accumulator
        }
    }
 
    mutating func setOperand(_ operand: Double) {
        accumulator = operand
    }
    
    var result: Double? {
        get {
            return accumulator
        }
    }
    
    private struct PendingBinaryOperation {
        let firstOperand: Double
        let function: (Double, Double) -> Double
        
        func perform(secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
        }
    }
}
