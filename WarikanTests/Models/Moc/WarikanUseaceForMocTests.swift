//
//  WarikanUseaceForMocTests.swift
//  Warikan
//
//  Created by Eiji Kushida on 2017/03/21.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import XCTest
@testable import Warikan

final class WarikanUseaceForMocTests: XCTestCase {
    
    let usecase = WarikanUsecase()
    let spyDelegete = SpyWarikanDelegate()    
    let moc = MocWarikan()
    
    override func setUp() {
        super.setUp()
        usecase.delegate = spyDelegete
        moc.delegate = self
    }
    
    override func tearDown() {
        super.tearDown()
        usecase.delegate = nil
        moc.delegate = nil
    }
    
    /// 割り切れない場合のテストケース
    /// check : 10,000 / 3 = 3,400
    /// 「1人辺りの支払い額は、3,400円です。」と表示されること
    func test10000div3() {
        
        moc.expectInternalOutput = "1人辺りの支払い額は、3,400円です。"
        whenCondition(description: "10000円を3人で割り勘したときのテスト")
        usecase.calc(totalAmountStr: "10000", numberOfPeopleStr: "3")
        verifySuccess()
    }
    
    /// 割り切れる場合のテストケース
    /// check : 10,000 / 2 = 5,000
    /// 「1人辺りの支払い額は、5,000円です。」と表示されること
    func test10000div2() {
        
        moc.expectInternalOutput = "1人辺りの支払い額は、5,000円です。"
        whenCondition(description: "10000円を2人で割り勘したときのテスト")
        usecase.calc(totalAmountStr: "10000", numberOfPeopleStr: "2")
        verifySuccess()
    }
    
    /// 合計金額が未入力の場合のテストケース
    /// check :「合計金額が未入力です。」と表示されること
    func testTotalAmountEmpty() {
        
        moc.expectInternalOutput = "合計金額が未入力です。"
        whenCondition(description: "合計金額が未入力のときのテスト")
        usecase.calc(totalAmountStr: "", numberOfPeopleStr: "2")
        verifyFailure()
    }
    
    /// 人数が未入力の場合のテストケース
    /// check :「人数が未入力です。」と表示されること
    func testNumberOfPeopleEmpty() {
        
        moc.expectInternalOutput = "人数が未入力です。"
        whenCondition(description: "人数が未入力のときのテスト")
        usecase.calc(totalAmountStr: "10000", numberOfPeopleStr: "")
        verifyFailure()
    }
    
    /// 合計金額に数値以外の文字列が指定された場合のテストケース
    /// check :「合計金額は数値を入力してください。」と表示されること
    func testTotalAmountIlligalFormat() {
        
        moc.expectInternalOutput = "合計金額は数値を入力してください。"
        whenCondition(description: "合計金額が数値以外のときのテスト")
        usecase.calc(totalAmountStr: "あいうえお", numberOfPeopleStr: "3")
        verifyFailure()
    }
    
    /// 人数に数値以外の文字列が指定された場合のテストケース
    /// check :「人数は数値を入力してください。」と表示されること
    func testNumberOfPeopleIlligalFormat() {
        
        moc.expectInternalOutput = "人数は数値を入力してください。"
        whenCondition(description: "人数が数値以外のときのテスト")
        usecase.calc(totalAmountStr: "10000", numberOfPeopleStr: "かきくけこ")
        verifyFailure()
    }
    
    /// 人数に2名未満の人数が指定された場合のテストケース
    /// check :「人数は2名以上入力してください。」と表示されること
    func testNumberOfPeopleLess2() {
 
        moc.expectInternalOutput = "人数は2名以上入力してください。"
        whenCondition(description: "人数が2名未満のときのテスト")
        usecase.calc(totalAmountStr: "10000", numberOfPeopleStr: "1")
        verifyFailure()
    }
    
    /// 前提条件を設定する
    private func whenCondition(description: String) {
        
        let exp = expectation(description: description)
        spyDelegete.asyncExpectation = exp
    }
    
    /// メッセージを確認する
    private func verifySuccess() {
        
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                
                XCTFail("waitForExpectationsエラー: \(error)")
                self.moc.actualInternalOutput = ""
            }
            
            switch self.spyDelegete.result! {
            case .success(let bugetStr):
                self.moc.actualInternalOutput = bugetStr
                
            case .error(_) :
                self.moc.actualInternalOutput = ""
            }
        }
    }
    
    private func verifyFailure() {
        
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                
                XCTFail("waitForExpectationsエラー: \(error)")
                self.moc.actualInternalOutput = ""
            }
            
            switch self.spyDelegete.result! {
            case .success(_):
                self.moc.actualInternalOutput = ""
                
            case .error(let message) :
                self.moc.actualInternalOutput = message
            }
        }
    }
}

// MARK :- MocWarikanDelegate
extension WarikanUseaceForMocTests: MocWarikanDelegate {
    
    func complated(result: Bool, expectInternalOutput: String) {
        XCTAssertTrue(result, expectInternalOutput)
    }
}
