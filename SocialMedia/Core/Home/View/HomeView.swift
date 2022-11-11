//
//  HomeView.swift
//  SocialMedia
//
//  Created by Belli's MacBook on 28/10/2022.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var globalDownload: GlobalDownload
    
    var body: some View {
        VStack{
            ScrollView{
                ForEach(globalDownload.postList ?? []){post in
                    PostCardView(postModel: post,
                                 userList: globalDownload.userList ?? [])
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(GlobalDownload())
    }
}
