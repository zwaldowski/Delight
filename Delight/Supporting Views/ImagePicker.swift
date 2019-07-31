//
//  ImagePicker.swift
//  Delight
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {

    static func isAvailable(_ type: UIImagePickerController.SourceType) -> Bool {
        return UIImagePickerController.isSourceTypeAvailable(type)
    }

    let sourceType: UIImagePickerController.SourceType
    @Binding var image: UIImage?

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

        @Binding var image: UIImage?
        init(image: Binding<UIImage?>) {
            self._image = image
        }

        func imagePickerController(_ imagePickerController: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            let image = info[.originalImage] as? UIImage
            imagePickerController.dismiss(animated: true) {
                self.image = image
            }
        }

        func imagePickerControllerDidCancel(_ imagePickerController: UIImagePickerController) {
            imagePickerController.dismiss(animated: true)
        }

    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(image: $image)
    }

}
