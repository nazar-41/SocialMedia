//
//  PostListView.swift
//  SocialMedia
//
//  Created by Belli's MacBook on 22/10/2022.
//

import SwiftUI

struct PostListView: View {
    //var postArr: [PostCardModel]
    //let startingPoint: PostCardModel
    
    var exploreArr: [ExploreCardModel]
    let startingPoint: ExploreCardModel
    
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
    
    private func sortList()-> [ExploreCardModel]{
        guard let startIndex = exploreArr.firstIndex(where: {$0 == startingPoint}) else {
            print("Errorroorororoororororooror")
            return []
        }
        
        let firstPart = exploreArr[startIndex..<exploreArr.count]
        let seconPart = exploreArr[0..<startIndex]
        
//        print("\n")
//        print("startIndex: \(startIndex), first part: \(firstPart)")
//        print("endIndex: \(exploreArr.count) first part: \(seconPart)")
//        print("\n")

        
        return Array(firstPart + seconPart)
    }
}

struct PostListView_Previews: PreviewProvider {
    static var previews: some View {
        PostListView(exploreArr: [dev.exploreCardModel_1, dev.exploreCardModel_2, dev.exploreCardModel_3],
                     startingPoint: dev.exploreCardModel_1)
    }
}
