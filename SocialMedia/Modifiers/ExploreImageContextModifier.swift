//
//  ExploreImageContextModifier.swift
//  SocialMedia
//
//  Created by Belli's MacBook on 18/10/2022.
//

import SwiftUI



struct ContextModifier: ViewModifier {
    // ContextMenu Modifier
    var card: ExploreCardModel

    func body(content: Content) -> some View {
        content
            .contextMenu(menuItems: {
                Text("By \(card.author)")
            })
            .contentShape(RoundedRectangle(cornerRadius: 5))
    }
}
