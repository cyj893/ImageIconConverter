//
//  AppIconConverter.swift
//  ImageIconConverter
//
//  Created by Yujin Cha on 2023/01/03.
//

import AppKit


enum MyError: Error {
    case testError
}

func makeError() throws {
    throw MyError.testError
}


struct AppIconConverter {
    
    static let directoryName = "AppIcon.appiconset"
    static let fileManager = FileManager.default
    static let baseDirectoryURL = fileManager
        .urls(for: .cachesDirectory,
              in: .userDomainMask)
        .first!
        .appendingPathComponent(directoryName)
    
    
    static func convert(image: NSImage, type: AppIconType) throws {
        try AppIconMaker.make(with: image, type: type, to: baseDirectoryURL)
        
        if let archiveURL = try zip(),
           let dstURL = showSavePanel() {
            try saveResult(at: archiveURL, to: dstURL)
        }
    }
    
}

extension AppIconConverter {
    
    static private func zip() throws -> URL? {
        var archiveURL: URL?
        var coordinateError: NSError?
        var fileManagerError: Error?

        let coordinator = NSFileCoordinator()
        
        coordinator.coordinate(readingItemAt: baseDirectoryURL,
                               options: [.forUploading],
                               error: &coordinateError) { (zipURL) in
            do {
//                try makeError()
                let tmpURL = try fileManager
                    .url(
                        for: .itemReplacementDirectory,
                        in: .userDomainMask,
                        appropriateFor: zipURL,
                        create: true
                    ).appendingPathComponent("\(directoryName).zip")
                try fileManager.moveItem(at: zipURL, to: tmpURL)
                archiveURL = tmpURL
            } catch {
                fileManagerError = error
            }
        }
        
        if let error = coordinateError {
            throw error
        }
        if let error = fileManagerError {
            throw error
        }

        return archiveURL
    }
    
    static private func showSavePanel() -> URL? {
        let savePanel = NSSavePanel()
        savePanel.allowedContentTypes = [.zip]
        savePanel.canCreateDirectories = true
        savePanel.isExtensionHidden = false
        savePanel.title = "Save icon images"
        savePanel.message = "Choose a folder and a name to store"
        savePanel.nameFieldLabel = "File Name:"
        savePanel.nameFieldStringValue = "AppIcon.appiconset"
        
        let response = savePanel.runModal()
        return response == .OK ? savePanel.url : nil
    }
    
    static private func saveResult(at resultURL: URL, to dstURL: URL) throws {
        if fileManager.fileExists(atPath: dstURL.path) {
            try fileManager.removeItem(at: dstURL)
        }
        try fileManager.moveItem(at: resultURL, to: dstURL)
    }
    
}
