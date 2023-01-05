//
//  ContentView.swift
//  ImageIconConverter
//
//  Created by Yujin Cha on 2022/12/25.
//

import SwiftUI
class ImageRepo: ObservableObject {
    @Published var image: NSImage?
}

extension ContentView {
    static let description = "Save the zip file that includes **converted images and '`Contents.json`'**.\n**After unzipping it**, You can change the app icon **by copying** it to the path **'_`Your-Project-Directory/Assets.xcassets`_'**"
    
    static let width = 600.0
}

struct ContentView: View {
    
    @ObservedObject var imageRepo = ImageRepo()
    
    var body: some View {
        VStack(alignment: .center, spacing: Spacing.offset) {
            OptionView(imageRepo: imageRepo)
            
            Text(.init(ContentView.description))
                .multilineTextAlignment(.center)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
            
            InputImageView(imageRepo: imageRepo)
        }
        .frame(width: ContentView.width)
        .padding(Spacing.offset)
    }
    
}



#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif


