//
//  PostCardView.swift
//  SocialMedia
//
//  Created by Belli's MacBook on 28/10/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct PostCardView: View {
    let profileImage: String?
    let postModel: PostModel
    let userList: [ContactModel]
    
    
    
    var body: some View {
        VStack(spacing: 0){
            HStack(spacing: 0){
                WebImage(url: URL(string: profileImage ?? ""))
                    .resizable()
                    .placeholder {
                        Circle()
                            .fill(.gray.opacity(0.5))
                            .frame(width: 30, height: 30)
                    }
                    .scaledToFit()
                    .clipShape(Circle())
                    .frame(width: 50, height: 50)
                
                if let authorData = getAuthorData(userList: userList){
                    VStack(alignment: .leading){
                        Text("\(authorData.name) \(authorData.surname)")
                            .font(.system(size: 15, weight: .bold))
                        
                        
                        Text(authorData.username)
                            .font(.system(size: 13, weight: .bold))
                            .foregroundColor(.gray)
                        
                    }
                }else{
                    ProgressView()
                }

                Spacer()
                
                
            }
            
            VStack{
                Text(postModel.text)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 13, weight: .medium))
            }
            .padding(10)
            
            
            WebImage(url: URL(string: postModel.image))
                .resizable()
                .placeholder {
                    Rectangle().foregroundColor(.gray.opacity(0.5))
                        .frame(maxWidth: .infinity, maxHeight: 300)
                }
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width)
            
            
            HStack{
                Button {
                    //more code here
                   // model.isLiked.toggle()
                } label: {
                    //MARK: solve this like function
//                    Image(systemName: model.isLiked ? "heart.fill" : "heart")
//                        .foregroundColor(model.isLiked ? .red : .black)
                    
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                }
                
                Button {
                    //more code here
                    
                } label: {
                    Image(systemName: "message")
                }
                
                Spacer()
                
                Text(postModel.date)
                    .foregroundColor(.gray)
                    .font(.system(size: 10))
                
            }
            .font(.system(size: 20, weight: .medium))
            .foregroundColor(.black)
            .padding(.horizontal, 10)
            .padding(.top, 10)
            
            Text("\(postModel.likes) likes")
                .font(.system(size: 15, weight: .medium))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 10)
                .padding(.top, 5)
            
            HStack{
                Button {
                    //more code here
                } label: {
                    Text("View all comments")
                        .foregroundColor(.gray)
                        .font(.system(size: 14, weight: .medium))
                    
                }
                Spacer()
            }
            .padding(.horizontal, 10)
            .padding(.top, 5)
            
        }
    }
    
    private func getAuthorData(userList: [ContactModel])-> ContactModel?{
        
        return userList.first(where: {$0.email == postModel.author})
        
    }
}

struct PostCardView_Previews: PreviewProvider {
    static var previews: some View {
        PostCardView(profileImage: "https://picsum.photos/id/117/1544/1024",
                     postModel: dev.postCardModel,
                     userList: [dev.contact_1, dev.contact_2, dev.contact_3])
    }
}
