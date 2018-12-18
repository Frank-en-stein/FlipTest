//
//  Extensions.swift
//  FlipTest
//
//  Created by S. M. Faisal Rahman on 12/18/18.
//  Copyright © 2018 asd. All rights reserved.
//

import UIKit

extension UIViewController {

    func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }

}
