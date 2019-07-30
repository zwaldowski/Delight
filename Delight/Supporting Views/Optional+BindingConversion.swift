//
//  Optional+BindingConversion.swift
//  Delight
//

import Foundation

extension Optional where Wrapped: StringProtocol {

    var orEmpty: Wrapped {
        get {
            return self ?? ""
        }
        set {
            self = newValue
        }
    }

}

extension Optional where Wrapped == Date {

    var orNow: Date {
        get {
            return self ?? Date()
        }
        set {
            self = newValue
        }
    }

}
