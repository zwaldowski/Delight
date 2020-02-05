//
//  OptionsButton.swift
//  SoManyOptions
//

import SwiftUI

struct OptionsButton<Label, Destination>: View where Label: View, Destination: View {

    typealias Builder = ArrayBuilder<Option<Destination>>
    typealias Options = [Option<Destination>]

    let label: Label
    let options: Options
    @State var isShowingMenu = false
    @State var selectedOption: Option<Destination>?

    init(label: Label, @Builder options: () -> Options) {
        self.label = label
        self.options = options()
    }

    func makeActionSheet() -> ActionSheet {
        ActionSheet(
            title: Text("Select an option"),
            buttons: options.map { (option) in
                Alert.Button.default(option.label) {
                    self.selectedOption = option
                }
            } + [ .cancel() ])
    }

    var body: some View {
        Button(action: showMenu) { self.label }
            .actionSheet(isPresented: $isShowingMenu, content: makeActionSheet)
            .sheet(item: $selectedOption) { $0.destination() }
    }

    func showMenu() {
        isShowingMenu = true
    }

}

extension OptionsButton where Label == Text {

    init(_ titleKey: LocalizedStringKey, @Builder options: () -> Options) {
        self.init(label: Label(titleKey), options: options)
    }

    init<S>(_ title: S, @Builder options: () -> Options) where S: StringProtocol {
        self.init(label: Label(title), options: options)
    }

}
