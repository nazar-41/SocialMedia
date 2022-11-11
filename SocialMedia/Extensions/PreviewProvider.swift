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
    
    let contact_1 = ContactModel(id: "",
                                 name: "Nazar",
                                 surname: "Velkakayev",
                                 username: "@n41",
                                 email: "nazarwelkakayew41@gmail.com",
                                 phoneNumber: "99365590939",
                                 createdDate: "200",
                                 profile_image: "https://picsum.photos/id/1070/5472/3648")
    
    let contact_2 = ContactModel(id: "",
                                 name: "John",
                                 surname: "Doe",
                                 username: "johndoe",
                                 email: "jphndoe@gmail.com",
                                 phoneNumber: "99365123456",
                                 createdDate: "",
                                 profile_image: "https://picsum.photos/id/1070/5472/3648")
    
    let contact_3 = ContactModel(id: "",
                                 name: "Steve",
                                 surname: "Jobs",
                                 username: "steve_apple",
                                 email: "stevejobs@gmail.com",
                                 phoneNumber: "99365123456",
                                 createdDate: "",
                                 profile_image: "https://picsum.photos/id/1070/5472/3648")
    
    
    let postCardModel = PostModel(id: "wertykjhgf2345678iuhgfdfg", author: "nazarwelkakayew41@gmail.com",
                                  text: "A book is a medium for recording information in the form of writing or images, typically composed of many pages (made of papyrus, parchment, vellum, or paper) bound",
                                  image: "https://picsum.photos/id/1070/5472/3648",
                                  date: "\(Date())",
                                  likes: [""],
                                  comments: [PostCommentModel(sender: "fwnwioneoiwe", comment: "nice job")])
    
    
    
}
