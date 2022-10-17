//
//  PreviewProvider.swift
//  SocialMedia
//
//  Created by Belli's MacBook on 17/10/2022.
//

import SwiftUI


extension PreviewProvider{
    static var dev: DeveloperPreview{
        return DeveloperPreview.instance
    }
}


class DeveloperPreview{
    static let instance = DeveloperPreview()
    init(){}
    
    let exploreCardModel = ExploreCardModel(id: "117",
                                            author: "Daniel Ebersole",
                                            downloadURL: "https://picsum.photos/id/117/1544/1024")
    
}
