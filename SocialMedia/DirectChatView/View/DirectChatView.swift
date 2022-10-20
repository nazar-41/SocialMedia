//
//  DirectChatView.swift
//  SocialMedia
//
//  Created by Belli's MacBook on 19/10/2022.
//

import SwiftUI

struct DirectChatView: View {
    @State private var message: String = ""
    @Environment(\.presentationMode) private var presentationMode
    
    @State private var chatArr: [FakeChatModel] = [FakeChatModel(contact: DeveloperPreview.instance.contact_1, isUser: true, message: "Hello John Doe"), FakeChatModel(contact: DeveloperPreview.instance.contact_1, isUser: false, message: "Hi Nazar, how are you?")]
    
    let contact: ContactModel
    var body: some View {
            VStack{
                HStack {
                    
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                            .font(.headline)
                            .padding()
                    }

                    Spacer()

                    
                    VStack{
                        Circle()
                            .frame(width: 40, height: 40)
                        
                        Text("\(contact.name) \(contact.surname)")
                            .font(.headline)
                    }
                    .padding(.trailing, 30)

                    
                    Spacer()

                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 10)
                .background(.gray.opacity(0.1))
                
                ScrollViewReader{proxy in
                    ScrollView{
                        ForEach(chatArr){message in
                            Text(message.message)
                                .foregroundColor(.white)
                                .padding(10)
                                .background(message.isUser ? .green : .blue)
                                .cornerRadius(10)
                                .padding(.horizontal)
                                .frame(maxWidth: .infinity, alignment: message.isUser ? .trailing : .leading)
                            
                        }
                    }
                    .onChange(of: chatArr.count) { _ in
                        scrollToLastMessage(proxy: proxy)
                    }
                    
                }
                HStack(spacing: 0){
                    ZStack{
                        Color.blue.opacity(0.05)
                            .cornerRadius(10)
                        TextField("Message", text: $message)
                            .ignoresSafeArea(.keyboard, edges: .bottom)
                            .padding(.horizontal)
                            .onSubmit {
                                sendMessage()
                            }
                    }
                    .frame(maxWidth: .infinity, maxHeight: 40)
                    
                    Button {
                        //more code here
                        
                        sendMessage()
                        

                    } label: {
                        Image(systemName: "paperplane")
                            .foregroundColor(.blue)
                            .padding(10)
                    }
                }
                .padding(10)


            }
            .navigationBarHidden(true)
    }
    
    private func sendMessage(){
        let newModel = FakeChatModel(contact: contact, isUser: true, message: message)
        chatArr.append(newModel)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
            let botModel = FakeChatModel(contact: contact, isUser: false, message: message)
            chatArr.append(botModel)
            
            message = ""

        }
        
    }
    
    private func scrollToLastMessage(proxy: ScrollViewProxy) {
        if let lastMessage = chatArr.last { // 4
            withAnimation(.easeOut(duration: 0.4)) {
                proxy.scrollTo(lastMessage.id, anchor: .bottom) // 5
            }
        }
    }
}

struct DirectChatView_Previews: PreviewProvider {
    static var previews: some View {
        DirectChatView(contact: dev.contact_1)
    }
}
