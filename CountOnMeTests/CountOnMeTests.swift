//
//  CountOnMeTests.swift
//  CountOnMeTests
//
//  Created by Lauriane Haydari on 22/07/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//


@testable import CountOnMe

import XCTest

final class ViewModelTests: XCTestCase {

    var viewModel: CalculatorViewModel!

    override func setUp() {
        super.setUp()
        viewModel = CalculatorViewModel()
    }

    // viewModel.viewDidLoad() => displayedText("1+2=3")
    func testGivenAViewModelWhenViewDidLoadThenDisplayedTextIsCorrctlyReturned() {
        let expectation = self.expectation(description: "Returned text : 0")
        viewModel.displayedText = { text in
            XCTAssertEqual(text, "0")
            expectation.fulfill()
        }
        viewModel.viewDidLoad()

        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testGiven2Minus1WhendidPressEqualButtonThendisplayTextResultIs1() {
        let expectation = self.expectation(description: "Returned text : 1")
        var counter = 0
        viewModel.displayedText = { text in
            if counter == 12 {
                XCTAssertEqual(text, "1")
                expectation.fulfill()
            }
            counter += 1
        }
        viewModel.viewDidLoad()
        viewModel.didPressOperand(operand: 2)
        viewModel.didPressOperator(at: 1)
        viewModel.didPressOperand(operand: 1)

        viewModel.didPressOperator(at: 4)

        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testGiven2MultiplyBy3WhendidPressEqualButtonThendisplayTextResultIs6() {
        let expectation = self.expectation(description: "Returned text : 6")
        var counter = 0
        viewModel.displayedText = { text in
            if counter == 12 {
                XCTAssertEqual(text, "6")
                expectation.fulfill()
            }
            counter += 1
        }
        viewModel.viewDidLoad()
        viewModel.didPressOperand(operand: 2)
        viewModel.didPressOperator(at: 2)
        viewModel.didPressOperand(operand: 3)

        viewModel.didPressOperator(at: 4)

        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testGiven4DivideBy2WhendidPressEqualButtonThendisplayTextResultIs2() {
        let expectation = self.expectation(description: "2")
        var counter = 0
        viewModel.displayedText = { text in
            if counter == 12 {
                XCTAssertEqual(text, "2")
                expectation.fulfill()
            }
            counter += 1
        }
        viewModel.viewDidLoad()
        viewModel.didPressOperand(operand: 4)
        viewModel.didPressOperator(at: 3)
        viewModel.didPressOperand(operand: 2)

        viewModel.didPressOperator(at: 4)

        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testGiven2Addition3WhenDidPressEqualButtonThenDisplayTextResultIs5() {
        let expectation = self.expectation(description: "Returned text : 5")
        var counter = 0
        viewModel.displayedText = { text in
            if counter == 12 {
                XCTAssertEqual(text, "5")
                expectation.fulfill()
            }
            counter += 1
        }
        viewModel.viewDidLoad()
        viewModel.didPressOperand(operand: 2)
        viewModel.didPressOperator(at: 0)
        viewModel.didPressOperand(operand: 3)

        viewModel.didPressOperator(at: 4)

        waitForExpectations(timeout: 1.0, handler: nil)
    }
    // + -
    func testGiven2Plus4Minus1Plus8WhenDidPressEqualButtonThendisplayTextResultIs13() {
        viewModel.viewDidLoad()
        viewModel.didPressOperand(operand: 2)
        viewModel.didPressOperator(at: 0)
        viewModel.didPressOperand(operand: 4)
        viewModel.didPressOperator(at: 1)
        viewModel.didPressOperand(operand: 1)
        viewModel.didPressOperator(at: 0)
        viewModel.didPressOperand(operand: 8)

        viewModel.didPressOperator(at: 4)

        viewModel.displayedText = { text in
            XCTAssertEqual(text, "13")
        }
    }
    // x +
    func testGiven2Multiply4Plus1WhenDidPressEqualButtonThendisplayTextResultIs9() {
        viewModel.viewDidLoad()
        viewModel.didPressOperand(operand: 2)
        viewModel.didPressOperator(at: 2)
        viewModel.didPressOperand(operand: 4)
        viewModel.didPressOperator(at: 0)
        viewModel.didPressOperand(operand: 1)

        viewModel.didPressOperator(at: 4)

        viewModel.displayedText = { text in
            XCTAssertEqual(text, "9")
        }
    }
    // x -
    func testGiven2Multiply4Minus1WhenDidPressEqualButtonThendisplayTextResultIs9() {
        viewModel.viewDidLoad()
        viewModel.didPressOperand(operand: 2)
        viewModel.didPressOperator(at: 2)
        viewModel.didPressOperand(operand: 4)
        viewModel.didPressOperator(at: 1)
        viewModel.didPressOperand(operand: 1)

        viewModel.didPressOperator(at: 4)

        viewModel.displayedText = { text in
            XCTAssertEqual(text, "7")
        }
    }
    // x + /
    func testGiven2Multiply4Plus1DivideBy2WhenDidPressEqualButtonThendisplayTextResultIs8Comma5() {
        viewModel.viewDidLoad()
        viewModel.didPressOperand(operand: 2)
        viewModel.didPressOperator(at: 2)
        viewModel.didPressOperand(operand: 4)
        viewModel.didPressOperator(at: 0)
        viewModel.didPressOperand(operand: 1)
        viewModel.didPressOperator(at: 3)
        viewModel.didPressOperand(operand: 2)

        viewModel.didPressOperator(at: 4)

        viewModel.displayedText = { text in
            XCTAssertEqual(text, "8.5")
        }
    }
    // x - /
    func testGiven2Multiply4Minus1DivideBy2WhenDidPressEqualButtonThendisplayTextResultIs8Comma5() {

        viewModel.viewDidLoad()
        viewModel.didPressOperand(operand: 2)
        viewModel.didPressOperator(at: 2)
        viewModel.didPressOperand(operand: 4)
        viewModel.didPressOperator(at: 1)
        viewModel.didPressOperand(operand: 1)
        viewModel.didPressOperator(at: 3)
        viewModel.didPressOperand(operand: 2)

        viewModel.didPressOperator(at: 4)

        viewModel.displayedText = { text in
            XCTAssertEqual(text, "7.5")
        }
    }

    func testGiven7Dot56multiply4Dot52WhenDidPressEqualButtonThendisplayTextResultIs() {
        viewModel.viewDidLoad()
        viewModel.didPressOperand(operand: 7)
        viewModel.didPressDotButton()
        viewModel.didPressOperand(operand: 5)
        viewModel.didPressOperand(operand: 6)
        viewModel.didPressOperator(at: 2)
        viewModel.didPressOperand(operand: 4)
        viewModel.didPressDotButton()
        viewModel.didPressOperand(operand: 5)
        viewModel.didPressOperand(operand: 2)

        viewModel.didPressOperator(at: 4)

        viewModel.displayedText = { text in
            XCTAssertEqual(text, "34.171")
        }
    }

    func testGiven3DivideBy6WhenDidPressEqualButtonThendisplayTextResultIsZeroComma5() {
        viewModel.viewDidLoad()
        viewModel.didPressOperand(operand: 3)
        viewModel.didPressOperator(at: 3)
        viewModel.didPressOperand(operand: 6)

        viewModel.didPressOperator(at: 4)

        viewModel.displayedText = { text in
            XCTAssertEqual(text, "0.5")
        }
    }

    func testGiven5Addition2Is5WhenDidPressclearButtonThenDisplayedTextIsCorrctlyCleared() {
        let expectation = self.expectation(description: "Returned text : nothing")
        var counter = 0
        viewModel.displayedText = { text in
            if counter == 7 {
                XCTAssertEqual(text, "")
                expectation.fulfill()
            }
            counter += 1
        }
        viewModel.viewDidLoad()
        viewModel.didPressOperand(operand: 5)
        viewModel.didPressOperator(at: 0)
        viewModel.didPressOperand(operand: 2)

        viewModel.didPressClear()

        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testGiven5AdditionWhenDidPressDeleteButtonThenDisplayedTextIsCorrectlyDeleted() {
        let expectation = self.expectation(description: "Returned text : 5+")
        var counter = 0
        viewModel.displayedText = { text in
            if counter == 5 {
                XCTAssertEqual(text, "5+")
                expectation.fulfill()
            }
            counter += 1
        }
        viewModel.viewDidLoad()
        viewModel.didPressOperand(operand: 5)
        viewModel.didPressOperator(at: 0)
        viewModel.didPressOperand(operand: 2)

        viewModel.didPressDelete()

        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testGiven5Plus2WhenDidPressDeleteButtonAndAdd1AndEqualThenDisplayedTextIs() {
        viewModel.viewDidLoad()
        viewModel.didPressOperand(operand: 5)
        viewModel.didPressOperator(at: 0)
        viewModel.didPressOperand(operand: 2)

        viewModel.didPressDelete()
        viewModel.didPressOperand(operand: 1)
        viewModel.didPressOperator(at: 4)

        viewModel.displayedText = { text in
            XCTAssertEqual(text, "6")
        }
    }

    func testGiven3DivideBy0WhendidPressEqualButtonThenAlertError() {
        let expectation = self.expectation(description: "Division par zéro impossible")
        viewModel.nextScreen = { screen in
            XCTAssertEqual(screen, .alert(title: "Alerte", message: "Division par zéro impossible"))
            expectation.fulfill()
        }
        viewModel.viewDidLoad()
        viewModel.didPressOperand(operand: 3)
        viewModel.didPressOperator(at: 3)
        viewModel.didPressOperand(operand: 0)

        viewModel.didPressOperator(at: 4)

        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testGiven5Addition2AndDidPressClearWhenDidPressOperatorButtonThenAlertError() {
        let expectation = self.expectation(description: "Commencez par un chiffre!")
        viewModel.nextScreen = { screen in
            XCTAssertEqual(screen, .alert(title: "Alerte", message: "Commencez par un chiffre!"))
            expectation.fulfill()
        }
        viewModel.viewDidLoad()
        viewModel.didPressOperand(operand: 5)
        viewModel.didPressOperator(at: 0)
        viewModel.didPressOperand(operand: 2)

        viewModel.didPressClear()

        viewModel.didPressOperator(at: 1)

        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testViewModelWhendidPressOperatorAgainThenAlertError() {
        let expectation = self.expectation(description: "Commencez par un chiffre!")
        viewModel.nextScreen = { screen in
            XCTAssertEqual(screen, .alert(title: "Alerte", message: "Commencez par un chiffre!"))
            expectation.fulfill()
        }
        viewModel.viewDidLoad()
        viewModel.didPressOperator(at: 1)
        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testViewModelWhendidPressOperatorThenAlertError() {
        let expectation = self.expectation(description: "Commencez par un chiffre!")
        viewModel.nextScreen = { screen in
            XCTAssertEqual(screen, .alert(title: "Alerte", message: "Commencez par un chiffre!"))
            expectation.fulfill()
        }
        viewModel.viewDidLoad()
        viewModel.didPressOperator(at: 0)
        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testGiven3PlusWhendidPressOperatorThenAlertError() {
        let expectation = self.expectation(description: "Entrez un chiffre après un opérateur!")
        viewModel.nextScreen = { screen in
            XCTAssertEqual(screen, .alert(title: "Alerte", message: "Entrez un chiffre après un opérateur!"))
            expectation.fulfill()
        }
        viewModel.viewDidLoad()
        viewModel.didPressOperand(operand: 3)
        viewModel.didPressOperator(at: 0)

        viewModel.didPressOperator(at: 0)

        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testGivenACalculatorViewModelWhenDidPressOperatorWithABadIndexThenNothingIsReturned() {

        let expectation = self.expectation(description: "Returned fail")
        expectation.isInverted = true

        var counter = 0
        viewModel.displayedText = { _ in
            if counter == 4 {
                XCTFail("count == 2")
                expectation.fulfill()
            }
            counter += 1
        }

        viewModel.viewDidLoad()

        viewModel.didPressOperand(operand: 1)

        viewModel.didPressOperator(at: 100000000000)

        waitForExpectations(timeout: 1.0, handler: nil)
    }
}
