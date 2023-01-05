//
//  Checkmark.swift
//  ImageIconConverter
//
//  Created by Yujin Cha on 2023/01/04.
//

import SwiftUI


struct Checkmark: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.fractionY(3, 4)))
        path.addLine(to: CGPoint(x: rect.fractionX(1, 3), y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.fractionY(1, 3)))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.fractionX(1, 3), y: rect.fractionY(3, 4)))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.fractionY(2, 4)))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.fractionY(3, 4)))

        return path
    }
}

#if DEBUG
struct Checkmark_Previews: PreviewProvider {
    static var previews: some View {
        Checkmark().frame(width: 300, height: 300)
    }
}
#endif
