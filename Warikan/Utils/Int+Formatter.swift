//
//  Int+Formatter.swift
//  Warikan
//
//  Created by Eiji Kushida on 2017/01/24.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import UIKit

extension Int {
    
    var bugetFormat: String {
        let decimalFormatter = NumberFormatter()
        decimalFormatter.numberStyle = NumberFormatter.Style.decimal
        decimalFormatter.groupingSeparator = ","
        decimalFormatter.groupingSize = 3
        
        return decimalFormatter.string(from: self as NSNumber)!
    }
}
