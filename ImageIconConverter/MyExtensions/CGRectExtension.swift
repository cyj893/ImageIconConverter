//
//  CGRectExtension.swift
//  ImageIconConverter
//
//  Created by Yujin Cha on 2023/01/04.
//

import Foundation

extension CGRect {
    func fractionX(_ numerator: Int, _ denominator: Int) -> CGFloat {
        return (maxX - minX) / CGFloat(denominator) * CGFloat(numerator) + minX
    }
    
    func fractionY(_ numerator: Int, _ denominator: Int) -> CGFloat {
        return (maxY - minY) / CGFloat(denominator) * CGFloat(numerator) + minY
    }
}
