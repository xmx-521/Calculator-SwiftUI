//
//  Model.swift
//  Calculator-SwiftUI
//
//  Created by 徐满心 on 2021/5/15.
//

import Foundation

struct Model {
    private(set) var currentNumberString: String = ""
    private(set) var result: String?
    
    mutating func setCurrentNumberString(as string:String) {
        currentNumberString = string
    }
    
    mutating func setResultNil(){
        result = nil
    }
    
    mutating func calculate() {
        if let num = currentNumberString.calculate() {
            result = "\(num)"
        } else {
            result = "ERROR"
        }
    }
    
}
