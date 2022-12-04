//
//  PostCardView.swift
//  SocialMedia
//
//  Created by Belli's MacBook on 28/10/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct PostCardView: View {
    let postModel: PostModel
    let userList: [ContactModel]
        
    @EnvironmentObject private var globaldownload: GlobalDownload
    
    @State private var showCommentSheet: Bool = false
    
    @State private var showUpdateSheet: Bool = false
    
    @AppStorage("email") private var email: String = ""

    
    
    var body: some View {
        VStack(spacing: 0){
            HStack(spacing: 0){
                WebImage(url: URL(string: globaldownload.getUserbyId(email: postModel.author)?.profile_image ?? ""))
                    .resizable()
                    .placeholder {
                        Circle()
                            .fill(.gray.opacity(0.5))
                            .frame(width: 30, height: 30)
                    }
                    .scaledToFit()
                    .clipShape(Circle())
                    .frame(width: 50, height: 50)
                
                if let authorData = getAuthorData(){
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
            }
            
            HStack{
                Button {
                    globaldownload.likeGivenPost(id: postModel.id)
                } label: {                    
                    Image(systemName: globaldownload.doesPostLiked(postID: postModel.id) ? "heart.fill" : "heart")
                        .foregroundColor(globaldownload.doesPostLiked(postID: postModel.id) ? .red : .gray)
                }
                
                Button {
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
        .contentShape(Rectangle())
        .contextMenu(postModel.author == email ?
                     ContextMenu {
            Button(role: .destructive) {
                globaldownload.deleteMyPost(post: postModel)
            } label: {
                Label("Delete", systemImage: "trash")
            }
            
            
            Button {
                showUpdateSheet = true
            } label: {
                Label("Update", systemImage: "pencil")
            }

        } : nil)
        
        .sheet(isPresented: $showCommentSheet) {
            PostCommentsSheet(post: postModel)
                .environmentObject(globaldownload)
        }
        .sheet(isPresented: $showUpdateSheet) {
            UpdatePostView(updatePostModel: postModel)
                .environmentObject(globaldownload)

        }
        

        
    }
    
    private func getAuthorData()-> ContactModel?{
        
        return userList.first(where: {$0.email == postModel.author})
        
    }
    

    
    private var isUsers: Bool{
        return true
    }
    
    

}

struct PostCardView_Previews: PreviewProvider {
    static var previews: some View {
        PostCardView(postModel: dev.postCardModel,
                     userList: [dev.contact_1, dev.contact_2, dev.contact_3])
        .environmentObject(GlobalDownload())
    }
}
