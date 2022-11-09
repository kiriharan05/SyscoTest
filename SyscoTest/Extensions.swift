//
//  Extensions.swift
//  SyscoTest
//
//  Created by ADL on 2022-11-09.
//

import Foundation
import UIKit

extension UIViewController {
    
    // Function that pop up limited internet connectivity alertView
    func noInternetAlert() {
        let alertController = UIAlertController(title: "No Internet Connection", message: "Please connect your device to Internet", preferredStyle: .alert)
        let OkAction = UIAlertAction(title: "OK", style: .default) { (action) in
        }
        alertController.addAction(OkAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    // Function that pop up error alertView with OK button
    func errorAlert(_ title: String,_ message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OkAction = UIAlertAction(title: "OK", style: .default) { (action) in
        }
        alertController.addAction(OkAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
