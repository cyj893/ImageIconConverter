//
//  AppIconType.swift
//  ImageIconConverter
//
//  Created by Yujin Cha on 2022/12/27.
//

import Foundation

enum AppIconType: Int {
    case iOS
    case macOS
    case watchOS
    
    var sizes: [Int] {
        switch self {
        case .iOS:
            return [20, 29, 40, 58, 60, 76, 80, 87, 120, 152, 167, 180, 1024]
        case .macOS:
            return [16, 32, 64, 128, 256, 512, 1024]
        case .watchOS:
            return [1024]
        }
    }
    
    var description: String {
        switch self {
        case .iOS:
            return "iOS"
        case .macOS:
            return "macOS"
        case .watchOS:
            return "watchOS"
        }
    }
    
    var jsonData: Data? {
        guard let fileLocation = Bundle.main.url(forResource: "\(description)Contents",
                                                 withExtension: "json") else { return nil }
        
        do {
            let data = try Data(contentsOf: fileLocation)
            return data
        } catch {
            return nil
        }
    }
}
