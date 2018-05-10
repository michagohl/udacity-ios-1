//
//  Helper.swift
//  pitchPerfect
//
//  Created by Michael Gohl on 10.05.18.
//  Copyright © 2018 Michael Gohl. All rights reserved.
//

import Foundation
import UIKit;

class Helper {
    var view:UIViewController!;
    
    init(_ caller:UIViewController) {
        view = caller;
    }
    
    func showAlert(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        view.present(alert, animated: true, completion: nil)
    }
}
