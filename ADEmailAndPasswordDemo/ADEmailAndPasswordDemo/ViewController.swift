//
//  ViewController.swift
//  ADEmailAndPasswordDemo
//
//  Created by Aniruddha Das on 12/27/16.
//  Copyright © 2016 Aniruddha Das. All rights reserved.
//

import UIKit
import ADEmailAndPassword

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print(ADEmailAndPassword.validateEmail(emailId: "adas@gmail.com"))
        
        print(ADEmailAndPassword.validatePassword(password: "13Wya@1oTg", length: 5, patternsToEscape: [], caseSensitivty: true, numericDigits: true))
        
        print(ADEmailAndPassword.checkPasswordStrength(password: "13Wya@1oTg"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

