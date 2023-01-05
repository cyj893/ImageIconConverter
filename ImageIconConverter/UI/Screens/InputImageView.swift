//
//  InputImageView.swift
//  ImageIconConverter
//
//  Created by Yujin Cha on 2022/12/25.
//

import SwiftUI


extension InputImageView {
    static let description = "**Input your image.** (**A square** of **1024px** or larger is recommended)"
    
    static let finderButtonText = "Open Finder"
    
    static let descriptionNil = "Please Input your image."
    static let descriptionGood = "Nice Image!"
    static let descriptionNotSquare = "It's not square. May be distorted."
    static let descriptionSize = "Less than 1024px. The quality won't be good."
    
    static let alertMessage = "Failed to open the image file"
}


struct InputImageView: View {
    
    @ObservedObject var imageRepo: ImageRepo
    @State private var showingAlert = false
    
    var body: some View {
        VStack(spacing: Spacing.offset) {
            HStack {
                Text(.init(InputImageView.description))
                Button(action: selectFile) {
                    Text(InputImageView.finderButtonText)
                }
                .customAlert(isPresented: $showingAlert, message: InputImageView.alertMessage)
            }
            DragAndDropView(imageRepo: imageRepo)
            Text(getImageDescription(imageRepo.image))
        }
    }
    
}


extension InputImageView {
    private func selectFile() {
        NSOpenPanel.openImage { (result) in
            switch result {
            case .success(let image):
                self.imageRepo.image = image
            case .failure(_):
                self.showingAlert = true
            }
        }
    }
    
    private func getImageDescription(_ image: NSImage?) -> String {
        guard let image = image else {
            return InputImageView.descriptionNil
        }
        
        if image.size.width != image.size.height {
            return InputImageView.descriptionNotSquare
        }
        
        if image.size.width < 1024 || image.size.height < 1024 {
            return InputImageView.descriptionSize
        }
        
        return InputImageView.descriptionGood
    }
}



#if DEBUG
struct InputImageView_Previews: PreviewProvider {
    
    static var previews: some View {
        InputImageView(imageRepo: ImageRepo())
    }
    
}
#endif
