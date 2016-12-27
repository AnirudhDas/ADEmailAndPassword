//
//  ValidateEmail.swift
//  AKStringHelper
//
//  Created by Aniruddha Das on 12/27/16.
//  Copyright © 2016 Aniruddha Das. All rights reserved.
//

import Foundation

enum PasswordStrength {
    case None
    case Weak
    case Moderate
    case Strong
}

public class ADEmailAndPassword {
    static func validateEmail(emailId: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: emailId)
    }
    
    static func validatePassword(password: String, length: Int, patternsToEscape: [String], caseSensitivty: Bool, numericDigits: Bool) -> Bool {
        if (password.characters.count < length) {
            return false
        }
        if caseSensitivty {
            let hasUpperCase = self.matchesForRegexInText(regex: "[A-Z]", text: password).count > 0
            if !hasUpperCase {
                return false
            }
            let hasLowerCase = self.matchesForRegexInText(regex: "[a-z]", text: password).count > 0
            if !hasLowerCase {
                return false
            }
        }
        if numericDigits {
            let hasNumbers = self.matchesForRegexInText(regex: "\\d", text: password).count > 0
            if !hasNumbers {
                return false
            }
        }
        if patternsToEscape.count > 0 {
            let passwordLowerCase = password.lowercased()
            for pattern in patternsToEscape {
                let hasMatchesWithPattern = self.matchesForRegexInText(regex: pattern, text: passwordLowerCase).count > 0
                if hasMatchesWithPattern {
                    return false
                }
            }
        }
        return true
    }
    
    static func matchesForRegexInText(regex: String, text: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex, options: [])
            let nsString = text as NSString
            let results = regex.matches(in: text,
                                        options: [], range: NSMakeRange(0, nsString.length))
            return results.map { nsString.substring(with: $0.range)}
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
    
    static func checkPasswordStrength(password: String) -> String {
        let len: Int = password.characters.count
        var strength: Int = 0
        
        switch len {
        case 0:
            return "None"
        case 1...4:
            strength += 1
        case 5...8:
            strength += 2
        default:
            strength += 3
        }
        
        // Upper case, Lower case, Number & Symbols
        let patterns = ["^(?=.*[A-Z]).*$", "^(?=.*[a-z]).*$", "^(?=.*[0-9]).*$", "^(?=.*[!@#%&-_=:;\"'<>,`~\\*\\?\\+\\[\\]\\(\\)\\{\\}\\^\\$\\|\\\\\\.\\/]).*$"]
        
        for pattern in patterns {
            if (password.range(of: pattern, options: .regularExpression) != nil) {
                strength += 1
            }
        }
        
        switch strength {
        case 0:
            return "None"
        case 1...3:
            return "Weak"
        case 4...6:
            return "Moderate"
        default:
            return "Strong"
        }
    }
}
