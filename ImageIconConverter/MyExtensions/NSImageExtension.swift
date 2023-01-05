//
//  NSImageExtension.swift
//  ImageIconConverter
//
//  Created by Yujin Cha on 2022/12/27.
//

import SwiftUI

extension NSImage {
    func getData(using type: NSBitmapImageRep.FileType) -> Data? {
        let imageRep = NSBitmapImageRep(data: tiffRepresentation!)
        return imageRep?.representation(using: type, properties: [:])
    }
    
    func resize(width: CGFloat, height: CGFloat) -> NSImage {
        return NSImage(size: NSMakeSize(width, height), flipped: false) { destSize in
            self.draw(in: NSMakeRect(0, 0, destSize.width, destSize.height),
                      from: NSMakeRect(0, 0, self.size.width, self.size.height),
                      operation: .sourceOver,
                      fraction: 1.0)
            return true
        }
    }
}
