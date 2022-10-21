//
//  SignUpView.swift
//  SocialMedia
//
//  Created by Belli's MacBook on 20/10/2022.
//

import SwiftUI

struct SignUpView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    
    @StateObject private var vm_loginsignup = VM_LoginSignup()
    
    var body: some View {
        VStack{
            Spacer()

            Image("asman_logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                //.blur(radius: 7)
            
            
            VStack{

                
                VStack{
                    Text("Sign up")
                        .font(.headline)
                        .padding(.top)
                    
                    HStack(spacing: 0){
                        Image(systemName: "envelope")
                        
                        TextField("email", text: $email)
                            .padding()
                            .padding(.trailing, 10)
                            .overlay(
                                Image(systemName: "xmark")
                                    .padding(5)
                                    .opacity(email.isEmpty ? 0 : 1)
                                    .onTapGesture {
                                        UIApplication.shared.endEditing()
                                        email = ""
                                    }
                                
                                , alignment: .trailing
                            )
                            .disableAutocorrection(true)
                            .keyboardType(.emailAddress)
                        
                        
                        
                    }
                    .font(.subheadline)
                    .padding(.horizontal, 5)
                    .padding(.horizontal)
                    
                    Divider()
                    
                    HStack(spacing: 0){
                        Image(systemName: "lock")
                        
                        SecureField("password", text: $password)
                            .padding()
                            .padding(.trailing, 10)
                            .overlay(
                                Image(systemName: "xmark")
                                    .padding(5)
                                    .opacity(password.isEmpty ? 0 : 1)
                                    .onTapGesture {
                                        UIApplication.shared.endEditing()
                                        password = ""
                                    }
                                
                                , alignment: .trailing
                            )
                            .disableAutocorrection(true)
                        
                        
                        
                    }
                    .font(.subheadline)
                    .padding(.horizontal, 5)
                    .padding(.horizontal)

                }
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.white)
                        .shadow(color: .gray.opacity(0.4), radius: 10, x: 3, y: 3)
                )
                .padding()
                
                Button {
                    // more code here
                    vm_loginsignup.signup(email: email, password: password)
                } label: {
                    Text("Register")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding(10)
                        .foregroundColor(.white)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.gray.opacity(0.8))
                                .shadow(color: .gray.opacity(0.2), radius: 10, x: 3, y: 3)
                        )
                        .padding(.horizontal)

                    
                }
                
                HStack{
                    Text("Already have an account?")
                    
                    Button {
                        //more code here
                    } label: {
                        Text("Login")
                    }

                }
                .font(.caption)
                .padding(.top)

            }
            
            Spacer()
            Spacer()

        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
