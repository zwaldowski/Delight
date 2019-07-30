//
//  ImageWell.swift
//  Delight
//

import SwiftUI

struct ImageWell: View {

    @Binding var image: UIImage?

    enum Source: Options {
        case camera, photoLibrary

        var label: Text {
            switch self {
            case .camera:
                return Text("Take Photo")
            case .photoLibrary:
                return Text("Photo Library")
            }
        }

        var isAvailable: Bool {
            switch self {
            case .camera:
                return UIImagePickerController.isSourceTypeAvailable(.camera)
            case .photoLibrary:
                return UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
            }
        }
    }

    var body: some View {
        Group {
            if image != nil {
                ConfirmButton("Remove Image", action: remove)

                Image(uiImage: image!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(4)
            } else {
                OptionsButton("Add Image", of: Source.self) { (source) -> ImagePicker in
                    switch source {
                    case .camera:
                        return ImagePicker(sourceType: .camera, completion: self.picked)
                    case .photoLibrary:
                        return ImagePicker(sourceType: .photoLibrary, completion: self.picked)
                    }
                }
            }
        }
    }

    func picked(_ newImage: UIImage?) {
        withAnimation {
            image = newImage
        }
    }

    func remove() {
        withAnimation {
            image = nil
        }
    }

}
