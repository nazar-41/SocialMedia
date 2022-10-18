//
//  UIApplication.swift
//  SocialMedia
//
//  Created by Belli's MacBook on 18/10/2022.
//

import SwiftUI

extension UIApplication{
    func endEditing(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
