//
//  E_layout3.swift
//  SocialMedia
//
//  Created by Belli's MacBook on 18/10/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct E_layout3: View {
    let exploreImage: [ExploreCardModel]
    
    // width, padding: 30
    let width = UIScreen.main.bounds.width - 30
    
    var body: some View {
        HStack(spacing: 4) {
            VStack(spacing: 4) {
                if exploreImage.count >= 2 {
                    AnimatedImage(url: URL(string: exploreImage[1].downloadURL))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: (width / 3), height: 123)
                        .cornerRadius(4)
                      //  .modifier(ContextModifier(card: cards[1]))
                }
                if exploreImage.count == 3 {
                    AnimatedImage(url: URL(string: exploreImage[2].downloadURL))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: (width / 3), height: 123)
                        .cornerRadius(4)
                      //  .modifier(ContextModifier(card: cards[2]))
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)

            AnimatedImage(url: URL(string: exploreImage[0].downloadURL))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: (width - (width / 3) + 4), height: 250)
                .cornerRadius(4)
              //  .modifier(ContextModifier(card: cards[0]))
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
        
    }
}

struct E_layout3_Previews: PreviewProvider {
    static var previews: some View {
        E_layout3(exploreImage: [dev.exploreCardModel_1, dev.exploreCardModel_2, dev.exploreCardModel_3])
    }
}
