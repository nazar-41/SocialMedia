//
//  InvitedFriendCardView.swift
//  SocialMedia
//
//  Created by Belli's MacBook on 22/11/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct RequestCardView: View {
    @EnvironmentObject private var globalDownload: GlobalDownload
    
    @StateObject private var vm_inviteFriendCardView: VM_InvitedFriendCardView
    
    let id: String
    let type: PendingRequestEnum
    

    init(id: String, list: [ContactModel]?, type: PendingRequestEnum){
        self.id = id
        self.type = type
        _vm_inviteFriendCardView = StateObject(wrappedValue: VM_InvitedFriendCardView(id: id, list: list))
    }
    
    var body: some View {
        VStack(alignment: .leading){
           // if let contact = vm_inviteFriendCardView.contact{
                
                HStack(alignment: .center, spacing: 20){
                    //WebImage(url: URL(string: contact.profile_image))
                    Image(systemName: "person.circle.fill")
                        .resizable()
//                        .placeholder{
//                            Image(systemName: "person.circle.fill")
//                                .resizable()
//                                .scaledToFill()
//                                .frame(width: 50, height: 50)
//                                .foregroundColor(.gray)
//                        }
                        .frame(width: 40, height: 40)
                    
                        .scaledToFill()
                    
                    VStack(alignment: .leading){
                        //Text(contact.name + contact.surname)
                        Text("Nazar Velkakayev")
                            .font(.headline)
                        
                        //Text(contact.username)
                        Text("@n41")
                            .font(.caption)
                    }
                    
                    Spacer()
                    
                    HStack(spacing: 0){
                        if type == .received{
                            Button {
                                vm_inviteFriendCardView.acceptRequest(currentUser: globalDownload.currentUser)
                            } label: {
                                Image(systemName: "checkmark.circle.fill")
                                    .font(.system(size: 30))
                                    .foregroundColor(.blue)
                                    .padding(5)
                            }
                        }
                        
                        Button {
                        vm_inviteFriendCardView.rejectRequest(currentUser: globalDownload.currentUser)
                            
                            
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .font(.system(size: 30))
                                .foregroundColor(.red)
                                .padding(5)
                        }
                        
                    }
                }
//            }else{
//                HStack{
//                    ProgressView()
//                }
//            }
        }
    }
}

struct InvitedFriendCardView_Previews: PreviewProvider {
    static var previews: some View {
        RequestCardView(id: "18E1F882-5FF1-4B52-9861-FB5FF8F22AED", list: [], type: .received)
    }
}
