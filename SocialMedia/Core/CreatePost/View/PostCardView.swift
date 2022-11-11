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
        
    @EnvironmentObject private var globaldownload: GlobalDownload
    
    @State private var showCommentSheet: Bool = false
    
    
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
            
            VStack{
                if let postedImage = postModel.image,
                   !postedImage.isEmpty{
                    WebImage(url: URL(string: postedImage))
                        .resizable()
                        .placeholder {
                            Rectangle().foregroundColor(.gray.opacity(0.5))
                                .frame(maxWidth: .infinity, maxHeight: 300)
                        }
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.width)

                }
                
//                if let image = vm_postCardView.postImage{
//                    Image(uiImage: image)
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: UIScreen.main.bounds.width)
//
//                }
            }
           // .frame(minHeight: 50)
            .border(.red)

            
            
            HStack{
                Button {
                    //more code here
                   // model.isLiked.toggle()
                    globaldownload.likeGivenPost(id: postModel.id)
                } label: {                    
                    Image(systemName: globaldownload.doesPostLiked(postID: postModel.id) ? "heart.fill" : "heart")
                        .foregroundColor(globaldownload.doesPostLiked(postID: postModel.id) ? .red : .gray)
                }
                
                Button {
                    //more code here
                    showCommentSheet.toggle()
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
            
            Text("\(postModel.likes.count) likes")
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
            
            Divider()
                .padding(10)
            
        }
        .sheet(isPresented: $showCommentSheet) {
            PostCommentsSheet(post: postModel)
                .environmentObject(globaldownload)
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
        .environmentObject(GlobalDownload())
    }
}
