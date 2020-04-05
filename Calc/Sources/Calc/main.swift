// 4 + 5
struct ArithmaticExp {
    let operand1: Int
    let operand2: Int
    let operation: String
}

//BODMAS
let operationPriority:[String] = ["*", "/", "%", "+", "-"]

func main() {
    var equation = CommandLine.arguments
    equation.remove(at: 0)
    
    if (isArgumentValid(argumentList: equation)) {
        print ("Arguments entered are valid")
    } else {
        print ("Argument entered are not valid ")
        return
    }
   
    caluculate(equation: equation)
}


//MARK:- Validation
func isArgumentValid(argumentList: [String]) -> Bool {
    var isValid = false
    if  (argumentList.count == 0) {
        return isValid
    }
    
        for index in 0..<argumentList.count {
            if (index % 2 == 0) { // if its even index exp operand /numeric "9"
               isValid = isOperand(exp: argumentList[index])
                
            } else { // "*"
                isValid = isOperator(exp: argumentList[index])
            }
            
            if (isValid == false) {
                break
            }
            
        }
    
    return isValid
}


func isOperand(exp: String) -> Bool {
    if (Int(exp) != nil ) { // "9" or "*"
        return true
    } else {
        return false
    }
}

func isOperator(exp: String) -> Bool {

    if (Int(exp) == nil) {
        return true
    } else {
        return false
    }
}


func caluculate(equation: [String]){
    
    print(equation)
    if (equation.count == 1) {
         print (equation[0])
        return
    }
    // * + - / %
    for operation in operationPriority {
        
        for index in stride(from: 1, to: equation.count - 1, by: 2) { // 1, 3, 5 , 7
            let exp = equation[index]
            
            if (operation == exp) {
                let mathExp: ArithmaticExp = ArithmaticExp(operand1: Int(equation[index - 1])!, operand2: Int(equation[index + 1])!, operation: exp)
                let value = arithmeticOperation(binaryExp: mathExp)
                let newEquation:[String] = updateEquation(equation: equation, replaceIndex: index, calValue: value)
                caluculate(equation: newEquation)
                return
            }
        }
    }
}

func updateEquation(equation: [String], replaceIndex: Int, calValue: Int) -> [String] {
    var updatedEquation: [String] = []
    
    for index in 0..<equation.count {
        
        if (index == replaceIndex - 1 || index == replaceIndex + 1) {
            continue
        } else if (index == replaceIndex) {
            updatedEquation.append(String(calValue))
        } else {
            updatedEquation.append(equation[index])
        }
    }
    print("Calculating..\(updatedEquation)")
    return updatedEquation
}



//MARK:- Arithmetic OPERATIONS

func arithmeticOperation(binaryExp: ArithmaticExp) -> Int {
    let output:Int
    switch binaryExp.operation {
        case "+":
            output = addition(operand1: binaryExp.operand1, operand2: binaryExp.operand2)
        case "-":
            output = substraction(operand1: binaryExp.operand1, operand2: binaryExp.operand2)
        case "*":
            output = multiplication(operand1: binaryExp.operand1, operand2: binaryExp.operand2)
        case "/":
            output = division(operand1: binaryExp.operand1, operand2: binaryExp.operand2)
        case "%":
            output = modulus(operand1: binaryExp.operand1, operand2: binaryExp.operand2)
        default:
            output = 0
    }
    return output
}


func addition(operand1: Int, operand2: Int) -> Int{

    return operand1 + operand2
}

func substraction(operand1: Int, operand2: Int) -> Int{
    return operand1 - operand2
}

func multiplication(operand1: Int, operand2: Int) -> Int {
    return operand1 * operand2
}

func division(operand1: Int, operand2: Int) -> Int {
    
    /* if (operand2 == 0) {
    return 0
}
 */
    guard operand2 != 0 else {// if denominator is zero don't perform division
        return 0
    }
    
    return operand1 / operand2
}

func modulus(operand1: Int, operand2: Int) -> Int{
    return operand1 % operand2
}

main()
