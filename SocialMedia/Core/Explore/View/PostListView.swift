//
//  PostListView.swift
//  SocialMedia
//
//  Created by Belli's MacBook on 22/10/2022.
//

import SwiftUI

struct PostListView: View {
    let postArr: [PostCardModel]
    let startingPoint: PostCardModel
    
    var body: some View {
        VStack{
            HStack(spacing: 0){
                Image("asman_logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50)
                    .clipShape(Circle())
                
                Text("Social Media")
                
                Spacer()
            }
            .padding(.horizontal, 10)
            
            ScrollView{
                VStack(spacing: 20){
                    ForEach(postArr) { model in
                        PostItemView(model: model, image: Image("asman_logo"))
                    }
                }
            }
        }
    }
}

struct PostListView_Previews: PreviewProvider {
    static var previews: some View {
        PostListView(postArr: [dev.postCardModel, dev.postCardModel], startingPoint: dev.postCardModel)
    }
}
