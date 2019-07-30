//
//  OptionsButton.swift
//  SoManyOptions
//

import SwiftUI

protocol Options: CaseIterable, Identifiable {
    associatedtype ID = Self

    var label: Text { get }
    var isAvailable: Bool { get }
}

extension Options where ID == Self {
    var id: Self {
        return self
    }
}

extension Options {
    var isAvailable: Bool { true }
}

private extension Options {
    static var allAvailable: [Self] {
        allCases.filter { $0.isAvailable }
    }
}

struct OptionsButton<Option, Destination>: View where Option: Options, Destination: View {

    let label: () -> Text
    let sheetContent: (Option) -> Destination

    @State var isShowingMenu = false
    @State var selectedOption: Option?

    func makeActionSheet() -> ActionSheet {
        ActionSheet(title: Text("Select an option"), buttons: Option.allAvailable.map { (option) in
            .default(option.label) {
                self.selectedOption = option
            }
        } + [ .cancel() ])
    }

    var body: some View {
        Button(action: showMenu, label: label)
            .actionSheet(isPresented: $isShowingMenu, content: makeActionSheet)
            .sheet(item: $selectedOption, content: sheetContent)
    }

    func showMenu() {
        isShowingMenu = true
    }

}

extension OptionsButton {

    init(_ titleKey: LocalizedStringKey, of _: Option.Type, sheetContent: @escaping(Option) -> Destination) {
        self.label = { Text(titleKey) }
        self.sheetContent = sheetContent
        self._selectedOption = State<Option?>(wrappedValue: nil) // other bug?
    }

}
