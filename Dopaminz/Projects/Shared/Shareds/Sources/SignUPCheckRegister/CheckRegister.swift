//
//  CheckRegister.swift
//  Shareds
//
//  Created by 서원지 on 4/6/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import Foundation

public struct CheckRegister{
     
    //MARK:  이메일 체크
    @discardableResult
    public static func isValidateEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return predicate.evaluate(with: email)
    }
    
    @discardableResult
    public static func isValidateId(_ id:String) -> Bool {
        let idRegEx = "[A-Za-z0-9]{5,13}"
        let predicate = NSPredicate(format:"SELF MATCHES %@", idRegEx)
        return predicate.evaluate(with: id)
    }
     
//    @discardableResult
    public static func isValidatePassword(_ password: String) -> Bool {
        let passwordRegEx = "^[A-Za-z0-9!_@$%^&+=]{8,20}"
        let predicate = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return predicate.evaluate(with: password)
    }
    
    @discardableResult
    public static func validatePassword(_ input: String) -> Bool {
        let hasMoreThanOneNumber = (input.range(of: "[0-9]", options: .regularExpression) != nil)
        let hasMoreThanOneSpecialCharacter = (input.range(of: ".*[~\\!\\@#\\$%\\^&\\*]+.*", options: .regularExpression) != nil)
        let hasNumberLength = (input.range(of: ".{8,}", options: .regularExpression) != nil)
        let hasLowerCaseCharacters = (input.range(of: ".*[a-z]+.*", options: .regularExpression) != nil)
        
        // 모든 조건을 충족하지 않으면 false 반환
        if !hasMoreThanOneNumber && !hasMoreThanOneSpecialCharacter && !hasNumberLength && !hasLowerCaseCharacters {
            return false
        }
        
        return true
    }

    @discardableResult
    public static func isValidNickName(_ nickName: String) -> Bool {
        let regexPattern = #"^[A-Za-z]{1,10}$"#
        let nicknamePredicate = NSPredicate(format: "SELF MATCHES %@", regexPattern)
        return nicknamePredicate.evaluate(with: nickName)
    }
    
}


