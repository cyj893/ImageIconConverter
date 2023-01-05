//
//  RadioButtonsCollection.swift
//  ImageIconConverter
//
//  Created by Yujin Cha on 2023/01/04.
//

import SwiftUI


struct RadioButtonsCollection: View {
    
    var itemConfigs: RadioButtonItem.Configurations = .init()
    var shapeConfigs: RadioButtonShape.Configurations = .init()
    
    let options: [String]
    let descriptions: [String]
    
    @Binding var selectedIndex: Int
    
    
    var body: some View {
        ForEach(Array(options.indices), id: \.self) { i in
            RadioButtonItem(configs: itemConfigs,
                            shapeConfigs: shapeConfigs,
                            id: i,
                            title: options[i],
                            description: descriptions[i],
                            selectedIndex: $selectedIndex)
        }
    }
    
}
