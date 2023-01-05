//
//  OptionView.swift
//  ImageIconConverter
//
//  Created by Yujin Cha on 2023/01/03.
//

import SwiftUI


extension OptionView {
    static let radioDescription = "Choose your project's target:"
    static let radioOptions = [AppIconType.iOS.description,
                               AppIconType.macOS.description,
                               AppIconType.watchOS.description]
    static let radioDescriptions = ["Sizes: \(AppIconType.iOS.sizes)",
                                    "Sizes: \(AppIconType.macOS.sizes)",
                                    "Sizes: \(AppIconType.watchOS.sizes)"]
    
    static let convertButtonText = "Convert & Save!"
    
    static let alertMessage = "Failed to save images"
}


struct OptionView: View {
    
    @ObservedObject var imageRepo: ImageRepo
    @State var selectedIndex = 0
    @State private var showingAlert = false
    
    
    var body: some View {
        HStack(alignment: .center) {
            Text(OptionView.radioDescription)
                .font(.title3)
            
            HStack {
                RadioButtonsCollection(options: OptionView.radioOptions,
                             descriptions: OptionView.radioDescriptions,
                             selectedIndex: $selectedIndex)
            }
            
            Spacer()
            
            Button(action: convertAndSave) {
                Text(OptionView.convertButtonText)
            }
            .disabled(imageRepo.image == nil)
            .controlSize(.large)
            .customAlert(isPresented: $showingAlert,
                         message: OptionView.alertMessage)
        }
    }
    
}

extension OptionView {
    func convertAndSave() {
        do {
            try AppIconConverter
                .convert(image: imageRepo.image!,
                         type: AppIconType(rawValue: selectedIndex)!)
        } catch {
            showingAlert = true
        }
    }
}



#if DEBUG
struct OptionView_Previews: PreviewProvider {
    static var previews: some View {
        OptionView(imageRepo: ImageRepo())
    }
}
#endif
