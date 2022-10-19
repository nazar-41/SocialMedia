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
    
    let exploreCardModel_1 = ExploreCardModel(id: "117",
                                            author: "Daniel Ebersole",
                                            downloadURL: "https://picsum.photos/id/117/1544/1024")
    
    let exploreCardModel_2 = ExploreCardModel(id: "117",
                                            author: "Daniel Ebersole",
                                            downloadURL: "https://picsum.photos/id/1084/4579/3271")
    
    let exploreCardModel_3 = ExploreCardModel(id: "117",
                                              author: "Daniel Ebersole",
                                              downloadURL: "https://picsum.photos/id/1070/5472/3648")
    
    let contact_1 = ContactModel(name: "Nazar",
                                 surname: "Velkakayev",
                                 username: "n41",
                                 email: "nazarwelkakayew41@gmail.com",
                                 phoneNumber: "99365590939")
    
    let contact_2 = ContactModel(name: "John",
                                 surname: "Doe",
                                 username: "johndoe",
                                 email: "jphndoe@gmail.com",
                                 phoneNumber: "99365123456")
    
    let contact_3 = ContactModel(name: "Steve",
                                 surname: "Jobs",
                                 username: "steve_apple",
                                 email: "stevejobs@gmail.com",
                                 phoneNumber: "99365123456")
    
}
