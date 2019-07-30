//
//  TextView.swift
//  Delight
//

import SwiftUI

struct TextView: UIViewRepresentable {

    @Binding var text: String

    func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        view.font = .preferredFont(forTextStyle: .body)
        view.adjustsFontForContentSizeCategory = true
        view.delegate = context.coordinator
        view.textContainerInset = .zero
        view.textContainer.lineFragmentPadding = 0
        view.keyboardDismissMode = .onDrag
        return view
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
        uiView.isEditable = context.environment.isEnabled
    }

    class Coordinator: NSObject, UITextViewDelegate {

        @Binding var text: String

        init(text: Binding<String>) {
            _text = text
        }

        func textViewDidChange(_ textView: UITextView) {
            text = textView.text ?? ""
        }

    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }

}
