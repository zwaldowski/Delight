//
//  Option.swift
//  Delight
//

import SwiftUI

struct Option<Destination>: Identifiable where Destination: View {
    let id = UUID()
    let label: Text
    let destination: () -> Destination
}

extension Option {

    init(_ titleKey: LocalizedStringKey, destination: @escaping() -> Destination) {
        self.init(label: Text(titleKey), destination: destination)
    }

    init<S>(_ title: S, destination: @escaping() -> Destination) where S: StringProtocol {
        self.init(label: Text(title), destination: destination)
    }

}
