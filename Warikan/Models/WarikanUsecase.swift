//
//  WarikanUsecase.swift
//  Warikan
//
//  Created by Eiji Kushida on 2017/01/24.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import UIKit

enum WarikanResult {
    case success(budget: String)
    case error(message: String)
}

protocol WarikanResultDelegate: class {
    func completed(result: WarikanResult)
}

final class WarikanUsecase {

    // 最小人数
    let minPeople = 2

    // 端数を100円単位に切り上げる
    let ceilingBase = 100

    weak var delegate: WarikanResultDelegate?

    func calc(totalAmountStr: String?, numberOfPeopleStr: String?) {

        guard let totalAmountStr = totalAmountStr, !totalAmountStr.isEmpty else {
            delegate?.completed(result: .error(message: WarikanError.totalAmountEmpty.message()))
            return
        }

        guard let numberOfPeopleStr = numberOfPeopleStr, !numberOfPeopleStr.isEmpty else {
            delegate?.completed(result: .error(message: WarikanError.numberOfPeopleEmpty.message()))
            return
        }

        guard totalAmountStr =~ "(^$)|(^\\d*$)" else {
            delegate?.completed(result: .error(message: WarikanError.totalAmountFormat.message()))
            return
        }

        guard numberOfPeopleStr =~ "(^$)|(^\\d*$)" else {
            delegate?.completed(result: .error(message: WarikanError.numberOfPeopleFormat.message()))
            return
        }

        if let totalAmount = Int(totalAmountStr), let numberOfPeople = Int(numberOfPeopleStr) {

            guard numberOfPeople >= minPeople else {
                delegate?.completed(result: .error(message: WarikanError.numberOfPeopleLess2.message()))
                return
            }

            let budget = Calc.div(totalAmount: totalAmount,
                                    numberOfPeople: numberOfPeople,
                                    ceilingBase: self.ceilingBase).bugetFormat

            let budgetStr = String(format:NSLocalizedString("buget", comment: ""), budget)
            delegate?.completed(result: .success(budget: budgetStr))
            return
        }
        fatalError("ありえないパターン")
    }
}
