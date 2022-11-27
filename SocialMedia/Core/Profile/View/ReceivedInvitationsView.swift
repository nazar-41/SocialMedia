//
//  ReceivedInvitationsView.swift
//  SocialMedia
//
//  Created by Belli's MacBook on 22/11/2022.
//

import SwiftUI

struct ReceivedInvitationsView: View {
    @EnvironmentObject private var globalDownload: GlobalDownload
    @Environment(\.presentationMode) private var presentationMode
    
    @State private var selected: Int = 0
    
    let receivedList: [String]
    let pendingList: [String]
    
    var body: some View {
        VStack {
            
            HStack{
                dismissButton
                Spacer()
            }
            
            HStack{
                Button {
                    withAnimation(.spring()) {
                        selected = 0
                    }
                } label: {
                    ZStack {
                        if selected == 0{
                            Color.blue.frame(height: 40)
                        }else{
                            Color.clear.frame(height: 40)
                        }
                        Text("Sent")
                            .foregroundColor(selected == 0 ? .white : .blue)
                            .font(.headline)
                    }
                }
                .border(.blue.opacity(selected == 0 ? 0 : 1))
                
                
                
                Button {
                    //more code here
                    withAnimation(.spring()){
                        selected = 1
                    }
                } label: {
                    ZStack {
                        
                        if selected == 1{
                            Color.blue.frame(height: 40)
                        }else{
                            Color.clear.frame(height: 40)
                        }
                        
                        Text("Received")
                            .foregroundColor(selected == 1 ? .white : .blue)
                            .font(.headline)
                    }
                }
                .border(.blue.opacity(selected == 1 ? 0 : 1))
            }
            .accentColor(.black)
            .padding(.horizontal, 10)
            
            
            VStack {
                HStack(spacing: 0){
                    if selected == 0{
                        ScrollView{
                            VStack{
                                ForEach(pendingList, id: \.self){id in
                                    RequestCardView(id: id, list: globalDownload.userList, type: .send)
                                        .environmentObject(globalDownload)
                                        .padding()
                                }
                            }
                        }
                        .transition(.move(edge: .leading))
                    }else{
                        ScrollView{
                            VStack{
                                ForEach(receivedList, id: \.self){id in
                                    RequestCardView(id: id, list: globalDownload.userList, type: .received)
                                        .environmentObject(globalDownload)
                                        .padding()
                                }
                            }
                        }
                        .transition(.move(edge: .trailing))
                    }
                }
                .frame(width: UIScreen.main.bounds.width, alignment: selected == 0 ? .leading: .trailing)
            }
            Spacer()
        }
    }
}

struct ReceivedInvitationsView_Previews: PreviewProvider {
    static var previews: some View {
        ReceivedInvitationsView(receivedList: [], pendingList: [])
    }
}


extension ReceivedInvitationsView{
    @ViewBuilder private var dismissButton: some View{
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            Image(systemName: "xmark")
                .padding()
        }
    }
}
