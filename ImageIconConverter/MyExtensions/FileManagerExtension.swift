//
//  FileManagerExtension.swift
//  ImageIconConverter
//
//  Created by Yujin Cha on 2023/01/03.
//

import Foundation

extension FileManager {
    static func clearDirectory(_ fileManager: FileManager = FileManager.default, at directoryURL: URL) throws {
        let contents = try fileManager
            .contentsOfDirectory(at: directoryURL,
                                 includingPropertiesForKeys: nil,
                                 options: [])
        for file in contents {
            try fileManager.removeItem(at: file)
        }
    }
    
    static func createDirectory(_ fileManager: FileManager = FileManager.default, at directoryURL: URL) throws {
        if fileManager.fileExists(atPath: directoryURL.path) {
            return
        }
        
        try fileManager
            .createDirectory(atPath: directoryURL.path,
                             withIntermediateDirectories: true,
                             attributes: nil)
    }
}
