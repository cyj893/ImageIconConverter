//
//  DragAndDropView.swift
//  ImageIconConverter
//
//  Created by Yujin Cha on 2023/01/03.
//

import SwiftUI


extension DragAndDropView {
    static let description = "Drag & Drop your image file"
    
    static let size = 512.0
    static let cornerRadius = 8.0
    
    static let alertMessage = "Failed to read the image file"
}


struct DragAndDropView: View {
    
    @ObservedObject var imageRepo: ImageRepo
    @State private var showingAlert = false
    
    
    var body: some View {
        ZStack {
            if imageRepo.image == nil {
                Text(DragAndDropView.description)
            } else {
                Image(nsImage: imageRepo.image!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
        .frame(width: DragAndDropView.size, height: DragAndDropView.size)
        .background(.black.opacity(0.5))
        .cornerRadius(DragAndDropView.cornerRadius)
        .onDrop(of: ["public.url", "public.file-url"],
                isTargeted: nil,
                perform: readFile)
        .customAlert(isPresented: $showingAlert,
                     message: DragAndDropView.alertMessage)
    }
    
}


extension DragAndDropView {
    func readFile(_ items: [NSItemProvider]) -> Bool {
        guard let item = items.first,
              let identifier = item.registeredTypeIdentifiers.first,
              identifier == "public.url" || identifier == "public.file-url" else {
            return false
        }
        
        item.loadItem(forTypeIdentifier: identifier, options: nil) { (urlData, error) in
            if let _ = error {
                showingAlert = true
                return
            }
            
            DispatchQueue.main.async {
                guard let urlData = urlData as? Data else { return }
                let url = NSURL(absoluteURLWithDataRepresentation: urlData, relativeTo: nil) as URL
                if let image = NSImage(contentsOf: url) {
                    self.imageRepo.image = image
                    print("Success to read the file")
                }
            }
        }
        
        return true
    }
}
