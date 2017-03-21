//
//  MocWarikan.swift
//  Warikan
//
//  Created by Eiji Kushida on 2017/03/21.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import XCTest
@testable import Warikan

protocol MocWarikanDelegate {
    func complated(result: Bool, expectInternalOutput: String)
}

final class MocWarikan: XCTestCase {
    
    /// 期待する間接出力
    var expectInternalOutput = ""
    
    /// 実際の間接出力
    var actualInternalOutput = "" {
        didSet{
            verify()
        }
    }
    var delegate: MocWarikanDelegate?
    
    /// 検証する
    func verify() {
        delegate?.complated(
            result: expectInternalOutput == actualInternalOutput,
            expectInternalOutput: expectInternalOutput
        )
    }
}

