//
//  ProfileView.swift
//  SocialMedia
//
//  Created by Belli's MacBook on 17/10/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProfileView: View {
    @EnvironmentObject private var vm_exploreView: VM_ExploreView
    @EnvironmentObject private var global_download: GlobalDownload
    @StateObject private var vm_profileView = VM_ProfileView()

    @State private var showSharePostSheet: Bool = false
    
    var body: some View {
        VStack{
            HStack(spacing: 10){
                Button {
                    //more core here
                } label: {
                    HStack{
                        Image(systemName: "bag")
                            .font(.system(size: 13, weight: .heavy))
                        
                        Text(vm_profileView.userProfile?.username ?? "-")
                            .font(.system(size: 19, weight: .heavy))
                    }
                }

                

                
                Spacer()
                
                Button {
                    //more code here
                    showSharePostSheet.toggle()
                } label: {
                    Image(systemName: "plus.square")
                        .font(.system(size: 19, weight: .semibold))
                }

                
                Button {
                    //more code here
                } label: {
                    Image(systemName: "text.justify")
                        .font(.system(size: 19, weight: .semibold))
                }
            }
            
            
            ScrollView(showsIndicators: false) {
                //profile main info
                mainInfo()
                
                VStack{
                    Button {
                        //
                    } label: {
                        ZStack{
                            Color.gray.opacity(0.15)
                                .cornerRadius(10)
                            
                            Text("Edit profile")
                                .font(.system(size: 14, weight: .bold))
                        }
                        .frame(height: 30)
                    }
                }
                
                if !vm_exploreView.compositionalArray.isEmpty{
                    VStack{
                        ForEach(vm_exploreView.compositionalArray[0...1].indices, id: \.self){index in
                            E_layout2(exploreImage: vm_exploreView.compositionalArray[index], allPosts: [])
                        }
                    }
                    .padding(.top)
                }else{
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                        .padding(.top, 200)
                }
                
                
                
            }
                        
            
            Spacer()
            
        }
        .padding(.horizontal)
       // .foregroundColor(.white)
        .accentColor(.black)
        .fullScreenCover(isPresented: $showSharePostSheet) {
            CreatePostView()
        }
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            
        ProfileView()
            .environmentObject(VM_ExploreView())
            .environmentObject(GlobalDownload())
        }

    }
}


extension ProfileView{
    //MARK: Profile main info
    @ViewBuilder private func mainInfo()-> some View{
        VStack(spacing: 10){
            HStack{
                
                Button {
                    //more code here
                } label: {
                    WebImage(url: URL(string: global_download.currentUser?.profile_image ?? ""))
                            .placeholder {
                                Image(systemName: "person.crop.circle.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 80, height: 80)
                                    .overlay (
                                        Image(systemName: "plus.circle.fill")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .symbolRenderingMode(.multicolor)
                                            .foregroundColor(.blue)
                                            .frame(width: 20, height: 20)
                                        
                                        , alignment: .bottomTrailing
                                    )
                            }
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                    
                }
                
                
                Spacer()
                
                HStack{
                    VStack(spacing: 5){
                        Text("\(vm_profileView.followers.count)")
                        
                        Text("Followers")
                    }
                    .font(.system(size: 14, weight: .bold))
                    
                    Spacer()
                    
                    VStack(spacing: 5){
                        Text("\(vm_profileView.followings.count)")

                        Text("Followings")
                    }
                    .font(.system(size: 14, weight: .bold))
                    
                    Spacer()
                    
                    NavigationLink{
                        ReceivedInvitationsView(receivedList: vm_profileView.receivedConnections,
                                                pendingList: vm_profileView.pendingConnections)
                            .environmentObject(global_download)
                            .navigationBarHidden(true)
                    }label: {
                        VStack(spacing: 5){
                            Text("\(vm_profileView.receivedConnections.count + vm_profileView.pendingConnections.count)")

                            Text("Requests")
                        }
                        .font(.system(size: 14, weight: .bold))
                    }
    
                    
                    
                }
                .padding(.horizontal, 10)
                .font(.system(size: 13, weight: .semibold))
                
            }
            .padding(.top)
            
            HStack{
                Text(vm_profileView.userProfile?.name ?? "-")
                    .font(.system(size: 13, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}
