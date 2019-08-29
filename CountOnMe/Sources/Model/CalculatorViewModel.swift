//
//  CalculatorViewModel.swift
//  CountOnMe
//
//  Created by Lauriane Haydari on 17/07/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import Foundation

enum NextScreen: Equatable {
    case alert(title: String, message: String)
}

final class CalculatorViewModel {

    // MARK: Private properties

    private var operandsString: [String] = [""]

    private var operatorsString: [String] = ["+"] // start always positive

    private let operatorCases = ["+",
                                 "-",
                                 "x",
                                 "/",
                                 "="]

    private var temporaryText = "" {
        didSet {
            displayedText?(temporaryText)
        }
    }

    private var total: Double = 0

    // MARK: - Outputs

    var displayedText: ((String) -> Void)?

    var nextScreen: ((NextScreen) -> Void)?

    // MARK: - Inputs

    func viewDidLoad() {
        temporaryText = "0"
    }

    /// Add operands
    func didPressOperand(operand: Int) {
        if let number = operandsString.last {
            var stringNumber = number
            stringNumber += "\(operand)"
            operandsString[operandsString.count-1] = stringNumber
            checkEqualButtonTapped()
            getText()
        }
    }

    /// Add operators
    func didPressOperator(at index: Int) {
        guard !temporaryText.isEmpty else {
            nextScreen?(.alert(title: "Alerte", message: "Commencez par un chiffre!"))
            return
        }
        guard let lastElement = temporaryText.last?.description, !operatorCases.contains(lastElement) else {
            nextScreen?(.alert(title: "Alerte", message: "Entrez un chiffre après un opérateur!"))
            return
        }
        guard index < operatorCases.count else {
            return
        }
        let stringOperator = operatorCases[index]

        if stringOperator == "=" {
            guard !temporaryText.contains("=") else {
                nextScreen?(.alert(title: "Alerte", message: "Opération terminée!"))
                return
            }
            processCalcul()
        } else {
            operatorsString.append(stringOperator)
            operandsString.append("")
            checkEqualButtonTapped()
            getText()
            checkOperandBegin()
        }
    }

    /// Add dot button
    func didPressDotButton() {
        let dot = "."
        if let number = operandsString.last {
            var decimal = number
            if let comma = decimal.last {
                if comma != dot.last {
                    if decimal == dot { decimal = "0\(dot)"}
                    decimal = (decimal) + dot
                    print ("decimal: \(decimal)")
                    operandsString[operandsString.count-1] = decimal
                    getText()
            } else {
                nextScreen?(.alert(title: "Alerte", message: "Ajoutez un chiffre après une virgule!"))
                clear()
                }
            }
        }
    }

    func didPressClear() {
        clear()
    }

    func didPressDelete() {
        clearLast()
    }

    // MARK: - Private Functions

    private func getText() {
        temporaryText = ""
        for (index, stringNumber) in operandsString.enumerated() {
            if index > 0 {
                temporaryText += operatorsString[index]
            }
            temporaryText += stringNumber
        }
        print ("temporaryText get text: \(temporaryText)")
    }

    func processCalcul() {
        checkZeroDivision()
        let total = getResult()
        temporaryText.removeAll()
        resetArrays()
        if total.first == "." {
            temporaryText.append("0\(total)")
        } else {
            temporaryText.append("\(total)")
        }
    }

    /// calculation priorities (select and reduce calcul with x or /)
    private func getCalculPriorities() {
        var operandS = operandsString
        var operatorS = operatorsString
        while operatorS.contains("x") || operatorS.contains("/") {
            if let indexOperator = operatorS.firstIndex (where: { $0 == "x" || $0 == "/" }) {
                let operatoR = operatorS[indexOperator]
                guard let operandLeft = Double(operandS[indexOperator - 1]) else { return }
                guard let openrandRight = Double(operandS[indexOperator]) else { return }
                if operatoR == "x" {
                    total = Double(operandLeft * openrandRight)
                } else {
                    total = Double(operandLeft / openrandRight)
                }
                // debug
                print ("operators : \(operatorS)")
                operatorS.remove(at: indexOperator)
                operandS[indexOperator - 1] = "\(total)"
                operandS.remove(at: indexOperator)
                operandsString = operandS
                print ("operandsString : \(operandsString)")
                operatorsString = operatorS
                print ("operators less x || / : \(operatorsString)")
            }
        }
    }

    /// calcul after reduce with + and - operators
    private func calcul() -> Double {
        var result: Double = 0
        for (index, operands ) in operandsString.enumerated() {
            if let number = Double(operands) {
                if operatorsString[index] == "+" {
                    result += number
                } else if operatorsString[index] == "-" {
                    result -= number
                }
                // debug
                print ("result : \(result)")
            }
        }
        resetArrays()
        return result
    }

    /// get the final result and format it with 3 numbers max after dot
    private func getResult() -> String {
        getCalculPriorities()
        let numberformatter = NumberFormatter()
        numberformatter.minimumFractionDigits = 0
        numberformatter.maximumFractionDigits = 3
        guard let total = numberformatter.string(from: NSNumber(value: calcul())) else { return "" }
        return total
    }

    /// clear operands and operators arrays, temporaryText and displayedText
    private func clear() {
        resetArrays()
        temporaryText.removeAll()
    }

    /// clear last in temporaryText and displayedText
    private func clearLast() {
        if temporaryText.last == operatorsString.last?.description.last {
            guard let element = operatorsString.last, let index = operatorsString.index(of: element) else { return }
            guard operatorsString[index].isEmpty == false else { return }
            operatorsString[index].removeLast()
        }

        if temporaryText.last == operandsString.last?.description.last {
            guard let element = operandsString.last, let index = operandsString.index(of: element) else { return }
            guard operandsString[index].isEmpty == false else { return }
            operandsString[index].removeLast()
        }

        temporaryText.removeLast()
    }

    private func resetArrays() {
        operatorsString = ["+"]
        operandsString =  [""]
    }
    // MARK: - Alerts
    private func checkZeroDivision() {
        if let operands = operandsString.last {
            if operands == "0" && operatorsString.last == "/" {
                nextScreen?(.alert(title: "Alerte", message: "Division par zéro impossible"))
                clear()
            }
        }
    }
    private func checkOperandBegin() {
        if let operands = operandsString.last {
            if operands.isEmpty {
                if let tempText = temporaryText.first {
                    if tempText == "+" || tempText == "-" || tempText == "x" || tempText == "/" {
                        nextScreen?(.alert(title: "Alerte", message: "Commencez par un chiffre!"))
                        clear()
                    }
                }
            }
        }
    }
    private func checkEqualButtonTapped() {
        if temporaryText.contains("=") {
            nextScreen?(.alert(title: "Alerte", message: "Entrez une expression correcte!"))
            clear()
        }
    }
}
