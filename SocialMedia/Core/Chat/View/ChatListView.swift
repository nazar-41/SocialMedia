//
//  ChatListView.swift
//  SocialMedia
//
//  Created by Belli's MacBook on 20/10/2022.
//

import SwiftUI

struct ChatListView: View {
    let chatListArr = [DeveloperPreview.instance.contact_1,
                       DeveloperPreview.instance.contact_2,
                       DeveloperPreview.instance.contact_3]
    
    var body: some View {
        VStack{
            ZStack(alignment: .top){
                Color.gray.opacity(0.1)
                    .edgesIgnoringSafeArea(.top)
                
                Text("Chat")
                    .font(.headline)
            }
            .frame(height: 30)

            List{
                ForEach(chatListArr) { contact in
                    NavigationLink{
                        DirectChatView(contact: contact)
                    }label: {
                        ContactRowView(contact: contact)
                            .listRowInsets(.init(top: 2, leading: 2, bottom: 2, trailing: 2))
                            .contentShape(Rectangle())
                    }
                }
            }
            .listStyle(.plain)
        }
    }
}

struct ChatListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ChatListView()
        }
    }
}
