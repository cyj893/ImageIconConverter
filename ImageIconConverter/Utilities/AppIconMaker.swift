//
//  AppIconMaker.swift
//  ImageIconConverter
//
//  Created by Yujin Cha on 2023/01/03.
//

import AppKit


struct AppIconMaker {
    static func make(with image: NSImage,
                     type: AppIconType,
                     to dstURL: URL) throws {
        try FileManager.clearDirectory(at: dstURL)
        try FileManager.createDirectory(at: dstURL)
        
        try makeImages(with: image, type: type, at: dstURL)
        try makeContentsJson(type: type, at: dstURL)
    }
    
    static private func makeImages(with image: NSImage,
                                   type: AppIconType,
                                   at directoryURL: URL) throws {
        for size in type.sizes {
            let resizedImage = image.resize(width: CGFloat(size), height: CGFloat(size))
            if let data = resizedImage.getData(using: .png) {
                let fileURL = directoryURL.appendingPathComponent("\(size)x\(size)px.png")
                try data.write(to: fileURL)
            }
        }
    }
    
    static private func makeContentsJson(type: AppIconType,
                                         at directoryURL: URL) throws {
        let jsonURL = directoryURL.appendingPathComponent("Contents.json")
        let jsonData = type.jsonData!
        try jsonData.write(to: jsonURL)
    }
}
