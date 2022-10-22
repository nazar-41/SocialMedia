//
//  PostItemView.swift
//  SocialMedia
//
//  Created by Belli's MacBook on 22/10/2022.
//

import SwiftUI
import SDWebImageSwiftUI


struct PostItemView: View {
    @State var model: PostCardModel
    //var image: Image
    
    var body: some View {
            VStack {
                HStack{
                    Circle()
                        .frame(width: 30)
                    
                    Text(model.author.author)
                        .font(.system(size: 14, weight: .medium))
                    
                    Spacer()
                    
                    Image(systemName: "ellipsis")
                }
                .padding(.horizontal)
                
                WebImage(url: URL(string: model.author.downloadURL))
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
                        model.isLiked.toggle()
                    } label: {
                        Image(systemName: model.isLiked ? "heart.fill" : "heart")
                            .foregroundColor(model.isLiked ? .red : .black)
                    }
                    
                    Button {
                        //more code here
                        
                    } label: {
                        Image(systemName: "message")
                    }
                    
                    Spacer()
                    
                }
                .font(.system(size: 20, weight: .medium))
                .foregroundColor(.black)
                .padding(.horizontal)
                
                Text("\(Int.random(in: 1..<300)) likes")
                    .font(.system(size: 15, weight: .medium))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top, 1)
                
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
                .padding(.horizontal)
                
            }
        }
}

struct PostItemView_Previews: PreviewProvider {
    static var previews: some View {
        PostItemView(model: dev.postCardModel_2)
            .previewLayout(.sizeThatFits)
    }
}
