//
//  ViewControllerTests.swift
//  Warikan
//
//  Created by Eiji Kushida on 2017/01/27.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

@testable import Warikan
import XCTest

class ViewControllerTests: XCTestCase {
    
    var viewController: ViewController?
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(
            withIdentifier: "ViewController")
        self.viewController = viewController as? ViewController
        
        _ = viewController.view
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testTotalAmountTextFieldAfterDidLoadIsNotNil() {
        XCTAssertNotNil(viewController?.totalAmountTextField)
    }
    
    func testNumberOfPeopleTextFieldAfterDidLoadIsNotNil() {
        XCTAssertNotNil(viewController?.numberOfPeopleTextField)
    }
    
    func testBudgetResultLabelAfterDidLoadIsNotNil() {

        XCTAssertNotNil(viewController?.budgetResultLabel)
    }

    func testTotalAmountTextFieldAfterDidLoadPlaceHolder() {
        XCTAssertEqual(viewController?.totalAmountTextField.placeholder,
                       "合計金額を入力してください。")
    }
    
    func testNumberOfPeopleTextFieldAfterDidLoadPlaceHolder() {
        XCTAssertEqual(viewController?.numberOfPeopleTextField.placeholder,
                       "人数を入力してください。")
    }
    
    func testBudgetResultLabelAfterDidLoadPlaceHolder() {
        XCTAssertEqual(viewController?.budgetResultLabel.text, "")
    }
}
