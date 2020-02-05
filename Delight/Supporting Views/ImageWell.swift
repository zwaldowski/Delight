//
//  ImageWell.swift
//  Delight
//

import SwiftUI

struct ImageWell: View {

    @Binding var image: UIImage?

    var body: some View {
        Group {
            if image != nil {
                ConfirmButton("Remove Image", action: remove)

                Image(uiImage: image!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(4)
            } else {
                OptionsButton("Add Image") {
                    if ImagePicker.isAvailable(.camera) {
                        Option("Take Photo") {
                            ImagePicker(sourceType: .camera, image: self.$image)
                        }
                    }

                    if ImagePicker.isAvailable(.photoLibrary) {
                        Option("Photo Library") {
                            ImagePicker(sourceType: .photoLibrary, image: self.$image)
                        }
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
