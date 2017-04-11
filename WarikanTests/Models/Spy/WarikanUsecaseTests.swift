//
//  WarikanUsecaseTests.swift
//  WarikanUsecaseTests
//
//  Created by Eiji Kushida on 2017/01/24.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

@testable import Warikan
import XCTest

class WarikanUsecaseTests: XCTestCase {

    let usecase = WarikanUsecase()
    let delegete = SpyWarikanDelegate()

    override func setUp() {
        super.setUp()
        usecase.delegate = delegete
    }
    
    override func tearDown() {
        super.tearDown()
        usecase.delegate = nil
    }

    /// 割り勘で切り上げる単位を確認するテストケース
    /// check : ceilingBase = 100
    func testDivBase() {
        XCTAssertEqual(usecase.ceilingBase, 100)
    }
    
    /// 割り勘で入力できる最少人数を確認するテストケース
    /// check : minPeople = 2
    func testMinPepople() {
        XCTAssertEqual(usecase.minPeople, 2)
    }
    
    /// 割り切れない場合のテストケース
    /// check : 10,000 / 3 = 3,400
    /// 「1人辺りの支払い額は、3,400円です。」と表示されること
    func test10000div3() {
        
        whenCondition(description: "10000円を3人で割り勘したときのテスト")
        usecase.calc(totalAmountStr: "10000", numberOfPeopleStr: "3")
        verifySuccess(result: "1人辺りの支払い額は、3,400円です。")
    }

    /// 割り切れる場合のテストケース
    /// check : 10,000 / 2 = 5,000
    /// 「1人辺りの支払い額は、5,000円です。」と表示されること
    func test10000div2() {
        
        whenCondition(description: "10000円を2人で割り勘したときのテスト")
        usecase.calc(totalAmountStr: "10000", numberOfPeopleStr: "2")
        verifySuccess(result: "1人辺りの支払い額は、5,000円です。")
    }
    
    /// 合計金額が未入力の場合のテストケース
    /// check :「合計金額が未入力です。」と表示されること
    func testTotalAmountEmpty() {
        
        whenCondition(description: "合計金額が未入力のときのテスト")
        usecase.calc(totalAmountStr: "", numberOfPeopleStr: "2")
        verifyFailure(result: "合計金額が未入力です。")
    }
    
    /// 人数が未入力の場合のテストケース
    /// check :「人数が未入力です。」と表示されること
    func testNumberOfPeopleEmpty() {
        
        whenCondition(description: "人数が未入力のときのテスト")
        usecase.calc(totalAmountStr: "10000", numberOfPeopleStr: "")
        verifyFailure(result: "人数が未入力です。")
    }
    
    /// 合計金額に数値以外の文字列が指定された場合のテストケース
    /// check :「合計金額は数値を入力してください。」と表示されること
    func testTotalAmountIlligalFormat() {
        
        whenCondition(description: "合計金額が数値以外のときのテスト")
        usecase.calc(totalAmountStr: "あいうえお", numberOfPeopleStr: "3")
        verifyFailure(result: "合計金額は数値を入力してください。")
    }
    
    /// 人数に数値以外の文字列が指定された場合のテストケース
    /// check :「人数は数値を入力してください。」と表示されること
    func testNumberOfPeopleIlligalFormat() {
        
        whenCondition(description: "人数が数値以外のときのテスト")
        usecase.calc(totalAmountStr: "10000", numberOfPeopleStr: "かきくけこ")
        verifyFailure(result: "人数は数値を入力してください。")
    }
    
    /// 人数に2名未満の人数が指定された場合のテストケース
    /// check :「人数は2名以上入力してください。」と表示されること
    func testNumberOfPeopleLess2() {
        
        whenCondition(description: "人数が2名未満のときのテスト")
        usecase.calc(totalAmountStr: "10000", numberOfPeopleStr: "1")
        verifyFailure(result: "人数は2名以上入力してください。")
    }
    
    /// 前提条件を設定する
    private func whenCondition(description: String) {
        let exp = expectation(description: description)
        delegete.asyncExpectation = exp
    }
    
    /// 期待通りに処理したことを確認する
    private func verifySuccess(result: String) {
        
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsエラー: \(error)")
            }
            
            switch self.delegete.result! {
            case .success(let bugetStr):
                XCTAssertEqual(bugetStr, result)
                
            case .error(_) :
                XCTFail("テスト失敗")
            }
        }
    }
    
    /// 期待通りに処理できなかったことを確認する
    private func verifyFailure(result: String) {
        
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsエラー: \(error)")
            }
            
            switch self.delegete.result! {
            case .success(_):
                XCTFail("テスト失敗")
            case .error(let message) :
                XCTAssertEqual(message, result)
            }
        }
    }
}
