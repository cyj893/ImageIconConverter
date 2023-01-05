//
//  RadioButtonShape.swift
//  ImageIconConverter
//
//  Created by Yujin Cha on 2023/01/03.
//

import SwiftUI


struct RadioButtonShape: View {
    
    struct Configurations {
        var shape: any Shape = Circle()
        var innerShape: any Shape = Circle()
        
        var shapeSize: CGFloat = 16.0
        var innerSize: CGFloat = 8.0
        
        var color: Color = .secondary
        var selectedColor: Color = .blue
        
        var lineWidth: CGFloat = 1.5
        var selectedLineWidth: CGFloat = 2.0
    }
    
    let configs: Configurations
    
    @Binding var isSelected: Bool
    
    
    var body: some View {
        AnyShape(configs.shape)
            .stroke(isSelected ? configs.selectedColor : configs.color,
                    lineWidth: isSelected ? configs.selectedLineWidth : configs.lineWidth)
            .frame(width: configs.shapeSize,
                   height: configs.shapeSize)
            .overlay(
                AnyShape(configs.innerShape)
                    .foregroundColor(isSelected ? configs.selectedColor : configs.color)
                    .frame(width: configs.innerSize,
                           height: configs.innerSize)
                    .opacity(isSelected ? 1.0 : 0.0)
            )
            .animation(.easeIn(duration: 0.2), value: isSelected)
    }
}
