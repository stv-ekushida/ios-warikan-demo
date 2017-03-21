//
//  WarikanError.swift
//  Warikan
//
//  Created by Eiji Kushida on 2017/01/24.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import Foundation

enum WarikanError: Error {
    
    case totalAmountEmpty       // 合計額が未入力
    case totalAmountFormat      // 合計額が数値でない    
    case numberOfPeopleEmpty    // 人数が未入力
    case numberOfPeopleFormat   // 人数が数値でない
    case numberOfPeopleLess2    // 人数が2人未満
    
    func message() -> String {
        
        switch self {
        case .totalAmountEmpty:
            return NSLocalizedString("totalAmountEmpty", comment: "")
            
        case .totalAmountFormat:
            return NSLocalizedString("totalAmountFormat", comment: "")

        case .numberOfPeopleEmpty:
            return NSLocalizedString("numberOfPeopleEmpty", comment: "")

        case .numberOfPeopleFormat:
            return NSLocalizedString("numberOfPeopleFormat", comment: "")

        case .numberOfPeopleLess2:
            return NSLocalizedString("numberOfPeopleLess2", comment: "")
        }
    }
}
