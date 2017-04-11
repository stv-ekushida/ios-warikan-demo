//
//  SpyWarikanDelegate.swift
//  Warikan
//
//  Created by Eiji Kushida on 2017/01/25.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

@testable import Warikan
import XCTest

class SpyWarikanDelegate: WarikanResultDelegate {
    
    var result: WarikanResult?
    var asyncExpectation: XCTestExpectation?
    
    func completed(result: WarikanResult) {
        
        guard let expectation = asyncExpectation else {
            XCTFail("SpyWarikanDelegateが正しく設定されていない")
            return
        }
        
        self.result = result
        expectation.fulfill()        
    }
}
