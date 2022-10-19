//
//  ContactRowView.swift
//  SocialMedia
//
//  Created by Belli's MacBook on 19/10/2022.
//

import SwiftUI

struct ContactRowView: View {
    let contact: ContactModel
    
    var body: some View {
        HStack{
            Circle()
                .frame(width: 40, height: 40)
            
            VStack(alignment: .leading){
                Text("\(contact.name) \(contact.surname)")
                    .font(.headline)
                
               // Text(contact.phoneNumber)
                Text("Seen yesterday at 09:42")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Image(systemName: "phone.arrow.up.right")
                .foregroundColor(.blue)
                .padding(10)
                .onTapGesture { makePhoneCall(contact: contact) }
        }
        .padding(.vertical, 5)
    }
    
    private func makePhoneCall(contact: ContactModel){
        let telephone = "tel://"
        let formattedString = telephone + contact.phoneNumber
        guard let url = URL(string: formattedString) else {
            print("error making phone call")
            return
        }
        UIApplication.shared.open(url)
    }
}

struct ContactRowView_Previews: PreviewProvider {
    static var previews: some View {
        ContactRowView(contact: dev.contact_1)
            .previewLayout(.sizeThatFits)
    }
}
