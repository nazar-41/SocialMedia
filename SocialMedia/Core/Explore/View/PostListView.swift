//
//  PostListView.swift
//  SocialMedia
//
//  Created by Belli's MacBook on 22/10/2022.
//

import SwiftUI

struct PostListView: View {
    var postArr: [PostCardModel]
    let startingPoint: PostCardModel
    
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        VStack{
            HStack(spacing: 0){
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .padding(10)
                        .foregroundColor(.black)
                }

                
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
                    ForEach(sortList()) { model in
                        PostItemView(model: model)
                    }
                }
            }
        }
        .navigationBarHidden(true)
    }
    
    private func sortList()-> [PostCardModel]{
        guard let startIndex = postArr.firstIndex(where: {$0 == startingPoint}) else {
            print("Errorroorororoororororooror")
            return []
        }
        
        let firstPart = postArr[startIndex..<postArr.count]
        let seconPart = postArr[0..<startIndex]
        
        return Array(firstPart + seconPart)
    }
}

struct PostListView_Previews: PreviewProvider {
    static var previews: some View {
        PostListView(postArr: [dev.postCardModel_1, dev.postCardModel_2, dev.postCardModel_3],
                     startingPoint: dev.postCardModel_1)
    }
}
