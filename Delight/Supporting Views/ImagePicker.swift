//
//  ImagePicker.swift
//  Delight
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {

    let sourceType: UIImagePickerController.SourceType
    let completion: (UIImage?) -> Void

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

        let completion: (UIImage?) -> Void
        init(completion: @escaping(UIImage?) -> Void) {
            self.completion = completion
        }

        func imagePickerController(_ imagePickerController: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            let image = info[.originalImage] as? UIImage
            imagePickerController.dismiss(animated: true) {
                self.completion(image)
            }
        }

        func imagePickerControllerDidCancel(_ imagePickerController: UIImagePickerController) {
            imagePickerController.dismiss(animated: true)
        }

    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(completion: completion)
    }

}
