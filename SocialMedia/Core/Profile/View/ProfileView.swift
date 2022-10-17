//
//  ProfileView.swift
//  SocialMedia
//
//  Created by Belli's MacBook on 17/10/2022.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack{
            HStack(spacing: 10){
                Button {
                    //more core here
                } label: {
                    HStack{
                        Image(systemName: "bag")
                            .font(.system(size: 13, weight: .heavy))
                        
                        Text("velkakayew_n")
                            .font(.system(size: 19, weight: .heavy))
                    }
                }

                

                
                Spacer()
                
                Button {
                    //more code here
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
                            Color.white.opacity(0.2)
                                .cornerRadius(10)
                            
                            Text("Edit profile")
                                .font(.system(size: 14, weight: .bold))
                        }
                        .frame(height: 30)
                    }
                }
            }
            
            
            
            
            Spacer()
            
        }
        .padding()
        .foregroundColor(.white)
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
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
                
                
                Spacer()
                
                HStack(spacing: 30){
                    VStack(spacing: 5){
                        Text("12")
                        
                        Text("Posts")
                    }
                    .font(.system(size: 14, weight: .bold))
                    
                    VStack(spacing: 5){
                        Text("142")
                        
                        Text("Followers")
                    }
                    .font(.system(size: 14, weight: .bold))
                    
                    VStack(spacing: 5){
                        Text("98")
                        
                        Text("Following")
                    }
                    .font(.system(size: 14, weight: .bold))
                    
                    
                }
                .font(.system(size: 13, weight: .semibold))
                
            }
            .padding(.top)
            
            HStack{
                Text("Nazar")
                    .font(.system(size: 13, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}
