//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet weak var screenTextView: UITextView!

    // MARK: - Properties

    private let viewModel = CalculatorViewModel()

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        bind(to: viewModel)
        viewModel.viewDidLoad()
    }

    private func bind(to viewModel: CalculatorViewModel) {
        viewModel.displayedText = { [weak self] text in
            self?.screenTextView.text = text
        }

        viewModel.nextScreen = { [weak self] screen in
            DispatchQueue.main.async {
                guard let self = self else { return }
                if case .alert(title: let title, message: let message) = screen {
                    AlertPresenter().presentAlert(on: self, with: title, message: message)
                }
            }
        }
    }

    // MARK: - View actions

    @IBAction func tappedOperandsButton(_ sender: UIButton) {
        guard let operandText = sender.title(for: .normal) else {
            return
        }
        viewModel.didPressOperand(operand: Int(operandText)!)
    }

    @IBAction func tappedOperatorButton(_ sender: UIButton) {
        viewModel.didPressOperator(at: sender.tag)
    }

    @IBAction func tappedDeleteButton(_ sender: Any) {
        viewModel.didPressDelete()
    }

    @IBAction func tappedClearButton(_ sender: Any) {
        viewModel.didPressClear()
    }

    @IBAction func tappedDotButton(_ sender: UIButton) {
        viewModel.didPressDotButton()
    }
}
