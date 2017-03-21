//
//  Calc.swift
//  Warikan
//
//  Created by Eiji Kushida on 2017/01/25.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import Foundation

final class Calc {
    
    // 割り算する（余りは、既定値で切り上げる）
    static func div(totalAmount: Int, numberOfPeople: Int, ceilingBase: Int) -> Int {
        
        guard numberOfPeople != 0 else {
            fatalError("0による除算はできません")
        }
        
        var result = totalAmount / numberOfPeople
        
        if !isDivisible(denominator: totalAmount, molecle: numberOfPeople) {
            result = ((result / ceilingBase) + 1) * ceilingBase
        }
        return result
    }
    
    // 割り切れるか？
    static func isDivisible(denominator: Int, molecle: Int) -> Bool {
        return denominator % molecle == 0
    }
}
