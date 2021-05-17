//
//  ViewModel.swift
//  Calculator-SwiftUI
//
//  Created by 徐满心 on 2021/5/15.
//

import SwiftUI

class ViewModel: ObservableObject {
    @Published var model = Model()
    @Published var isEntering: Bool = false
    
    var currentNumberString: String {
        model.currentNumberString
    }
    
    var result: String? {
        return model.result
    }
    
    func tapExpression(sign:String) {
        if isEntering {
            model.setCurrentNumberString(as: currentNumberString+sign)
        } else {
            model.setResultNil()
            model.setCurrentNumberString(as: sign)
            isEntering=true
        }
    }
    
    func tapEqual() {
        model.calculate()
        isEntering = false
    }
    
    func tapAllClear(){
        model.setCurrentNumberString(as: "")
        model.setResultNil()
        isEntering=false
    }
}
