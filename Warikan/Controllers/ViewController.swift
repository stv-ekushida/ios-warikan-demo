//
//  ViewController.swift
//  Warikan
//
//  Created by Eiji Kushida on 2017/01/24.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var totalAmountTextField: UITextField!
    @IBOutlet weak var numberOfPeopleTextField: UITextField!    
    @IBOutlet weak var budgetResultLabel: UILabel!
    
    //MARK:-Actions
    @IBAction func calcButtonDidTap(_ sender: UIButton) {
        
        let usecase = WarikanUsecase()
        usecase.delegate = self
        usecase.calc(totalAmountStr: totalAmountTextField.text,
                     numberOfPeopleStr: numberOfPeopleTextField.text)
    }
    
    @IBAction func backgroundViewDidTap(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
}

//MARK:- WarikanResultDelegate
extension ViewController: WarikanResultDelegate {
    
    func completed(result: WarikanResult) {
        
        switch result {
        case .success(let bugetStr):
            self.showResult(budget: bugetStr)

        case .error(let message):
            self.showAlert(message: message)
        }
    }
    
    private func showResult(budget: String) {
        budgetResultLabel.text = budget
            
    }
    
    private func showAlert(message: String) {
        
        present(AlertBuilder.buildMessage(message: message),
                animated: true,
                completion: nil)
    }
}
