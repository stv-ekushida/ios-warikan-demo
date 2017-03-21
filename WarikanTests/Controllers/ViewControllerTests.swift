//
//  ViewControllerTests.swift
//  Warikan
//
//  Created by Eiji Kushida on 2017/01/27.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import XCTest
@testable import Warikan

class ViewControllerTests: XCTestCase {
    
    var vc: ViewController!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(
            withIdentifier: "ViewController")
        vc = viewController as! ViewController
        
        _ = vc.view
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testTotalAmountTextFieldAfterDidLoadIsNotNil() {
        XCTAssertNotNil(vc.totalAmountTextField)
    }
    
    func testNumberOfPeopleTextFieldAfterDidLoadIsNotNil() {
        XCTAssertNotNil(vc.numberOfPeopleTextField)
    }
    
    func testBudgetResultLabelAfterDidLoadIsNotNil() {

        XCTAssertNotNil(vc.budgetResultLabel)
    }

    func testTotalAmountTextFieldAfterDidLoadPlaceHolder() {
        XCTAssertEqual(vc.totalAmountTextField.placeholder, "合計金額を入力してください。")
    }
    
    func testNumberOfPeopleTextFieldAfterDidLoadPlaceHolder() {
        XCTAssertEqual(vc.numberOfPeopleTextField.placeholder, "人数を入力してください。")
    }
    
    func testBudgetResultLabelAfterDidLoadPlaceHolder() {
        XCTAssertEqual(vc.budgetResultLabel.text, "")
    }
}
