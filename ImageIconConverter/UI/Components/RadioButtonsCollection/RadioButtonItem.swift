//
//  RadioButtonItem.swift
//  ImageIconConverter
//
//  Created by Yujin Cha on 2023/01/03.
//

import SwiftUI


struct RadioButtonItem: View {
    
    struct Configurations {
        var font: Font = .body
        var spacing: CGFloat = 5.0
        var popoverPadding: CGFloat = 16.0
    }
    
    let configs: Configurations
    var shapeConfigs: RadioButtonShape.Configurations
    
    let id: Int
    let title: String
    let description: String
    
    @Binding var selectedIndex: Int
    @State private var showPopover = false
    
    
    var body: some View {
        HStack(spacing: configs.spacing) {
            RadioButtonShape(configs: shapeConfigs,
                             isSelected: Binding(get: { selectedIndex == id }, set: { _ in }))
            Text(title)
                .font(configs.font)
        }
        .contentShape(Rectangle())
        
        .popover(isPresented: $showPopover) {
            Text(description)
                .padding(configs.popoverPadding)
        }
        
        .gesture(
            TapGesture()
                .onEnded({ _ in
                    if selectedIndex != id {
                        selectedIndex = id
                    }
                })
        )
        .gesture(
            LongPressGesture()
                .onEnded({ _ in
                    showPopover = true
                })
        )
    }
    
}
