//
//  ConfirmButton.swift
//  Delight
//

import SwiftUI

struct ConfirmButton<Label>: View where Label: View {

    let action: () -> Void
    let prompt: Text?
    let confirmation: Text
    let label: Label

    @State var isShowingConfirmation = false

    init(action: @escaping() -> Void, prompt: Text? = nil, confirmation: Text? = nil, @ViewBuilder label: () -> Label) {
        self.action = action
        self.prompt = prompt
        self.confirmation = confirmation ?? Text("Yes")
        self.label = label()
    }

    var body: some View {
        Button(action: confirm) { self.label }
            .actionSheet(isPresented: $isShowingConfirmation) {
                ActionSheet(title: Text("Are you sure?"), message: prompt, buttons: [
                    .destructive(confirmation, action: action), .cancel()
                ])
            }
    }

    func confirm() {
        isShowingConfirmation = true
    }

}

extension ConfirmButton where Label == Text {

    init(_ titleKey: LocalizedStringKey, prompt: Text? = nil, confirmation: Text? = nil, action: @escaping() -> Void) {
        self.init(action: action, prompt: prompt, confirmation: confirmation) {
            Text(titleKey)
                .foregroundColor(.red)
        }
    }

}
