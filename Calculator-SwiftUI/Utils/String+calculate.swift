//
//  String+calculate.swift
//  Calculator-SwiftUI
//
//  Created by 徐满心 on 2021/5/16.
//

import Foundation

extension String {

    private func allNumsToDouble() -> String {

        let symbolsCharSet = ".,"
        let fullCharSet = "0123456789" + symbolsCharSet
        var i = 0
        var result = ""
        let chars = Array(self)
        while i < chars.count {
            if fullCharSet.contains(chars[i]) {
                var numString = String(chars[i])
                i += 1
                loop: while i < chars.count {
                    if fullCharSet.contains(chars[i]) {
                        numString += String(chars[i])
                        i += 1
                    } else {
                        break loop
                    }
                }
                if let num = Double(numString) {
                    result += "\(num)"
                } else {
                    result += numString
                }
            } else {
                result += String(chars[i])
                i += 1
            }
        }
        return result
    }

    func calculate() -> Double? {
        let transformedString = allNumsToDouble()
        var answer: Double?
        SwiftTryCatch.try({
            let expr = NSExpression(format: transformedString)
            answer =  expr.expressionValue(with: nil, context: nil) as? Double
        }, catch: { (error) in
            answer = nil
             }, finallyBlock: {

        })
        return answer
    }
}
