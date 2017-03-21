//
//  AlertBuilder.swift
//  Warikan
//
//  Created by Eiji Kushida on 2017/01/25.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import UIKit

final class AlertBuilder {
    
    static func buildMessage(message: String) -> UIViewController{
        
        let alertController = UIAlertController(title: NSLocalizedString("alertTitle", comment: ""),
                                                message: message,
                                                preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        return alertController
    }
}
