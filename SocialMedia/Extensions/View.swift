//
//  View.swift
//  SocialMedia
//
//  Created by Belli's MacBook on 23/10/2022.
//

import SwiftUI
import Foundation


extension View {
    //MARK: round custom corner
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }
}
