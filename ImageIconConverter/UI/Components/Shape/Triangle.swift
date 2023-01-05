//
//  Triangle.swift
//  ImageIconConverter
//
//  Created by Yujin Cha on 2023/01/04.
//

import SwiftUI


struct Triangle: Shape {
    
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))

        return path
    }
}

#if DEBUG
struct Triangle_Previews: PreviewProvider {
    static var previews: some View {
        Triangle().frame(width: 300, height: 300)
    }
}
#endif
