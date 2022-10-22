//
//  UIImage.swift
//  SocialMedia
//
//  Created by Belli's MacBook on 17/10/2022.
//

import Foundation

import SwiftUI

extension UIImage {

    //MARK: get image size:
    /*
     Image
        .getSizeIn(.gigabyte)
     */
    public enum DataUnits: String {
        case byte, kilobyte, megabyte, gigabyte
    }

    func getSizeIn(_ type: DataUnits)-> String {

        guard let data = self.pngData() else {
            return ""
        }

        var size: Double = 0.0

        switch type {
        case .byte:
            size = Double(data.count)
        case .kilobyte:
            size = Double(data.count) / 1024
        case .megabyte:
            size = Double(data.count) / 1024 / 1024
        case .gigabyte:
            size = Double(data.count) / 1024 / 1024 / 1024
        }

        return String(format: "%.2f", size)
    }
    
    
    //MARK: get image resolution
    var getWidth: CGFloat {
        get {
            let width = self.size.width
            return width
        }
    }

    var getHeight: CGFloat {
        get {
            let height = self.size.height
            return height
        }
    }
}
