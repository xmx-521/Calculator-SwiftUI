//
//  String+Identifiable.swift
//  Calculator-SwiftUI
//
//  Created by 徐满心 on 2021/5/15.
//

import Foundation
extension String: Identifiable {
    public var id: String {
        self
    }
}
