//
//  ValidateEmail.swift
//  AKStringHelper
//
//  Created by Aniruddha Das on 12/27/16.
//  Copyright © 2016 Aniruddha Das. All rights reserved.
//

import Foundation

public extension String {
    
    public func validateEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return predicate.evaluate(with: self)
    }
    
}
