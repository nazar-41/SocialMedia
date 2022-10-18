//
//  E_layout2.swift
//  SocialMedia
//
//  Created by Belli's MacBook on 18/10/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct E_layout2: View {
    let exploreImage: [ExploreCardModel]
    
    // width, padding: 30
    let width = UIScreen.main.bounds.width - 30
    
    var body: some View {
        HStack(spacing: 4) {
            AnimatedImage(url: URL(string: exploreImage[0].downloadURL))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: (width / 3), height: 125)
                .cornerRadius(4)
                .modifier(ContextModifier(card: exploreImage[0]))

            if exploreImage.count >= 2 {
                AnimatedImage(url: URL(string: exploreImage[1].downloadURL))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: (width / 3), height: 125)
                    .cornerRadius(4)
                    .modifier(ContextModifier(card: exploreImage[1]))
            }

            if exploreImage.count == 3 {
                AnimatedImage(url: URL(string: exploreImage[2].downloadURL))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: (width / 3), height: 125)
                    .cornerRadius(4)
                    .modifier(ContextModifier(card: exploreImage[2]))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)    }
}

struct E_layout2_Previews: PreviewProvider {
    static var previews: some View {
        E_layout2(exploreImage: [dev.exploreCardModel_1, dev.exploreCardModel_2, dev.exploreCardModel_3])
    }
}
