//
//  Color+grayScale.swift
//  Calculator-SwiftUI
//
//  Created by 徐满心 on 2021/5/15.
//

import SwiftUI

extension Color {
    public init(grayScale:Double) {
        self.init(red: grayScale, green: grayScale, blue: grayScale)
    }
}
