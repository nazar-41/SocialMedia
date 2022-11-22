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
    
    let receivedList: [String]
    
    var body: some View {
        VStack {
            
            HStack{
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .padding()
                }
                
                Spacer()

            }
            
            ScrollView{
                VStack{
                    ForEach(receivedList, id: \.self){id in
                        InvitedFriendCardView(id: id, list: globalDownload.userList)
                            .environmentObject(globalDownload)
                            .padding()
                    }
                }
            }
        }
    }
}

struct ReceivedInvitationsView_Previews: PreviewProvider {
    static var previews: some View {
        ReceivedInvitationsView(receivedList: [])
    }
}
