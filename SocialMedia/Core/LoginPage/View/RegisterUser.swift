//
//  RegisterUser.swift
//  SocialMedia
//
//  Created by Belli's MacBook on 21/10/2022.
//

import SwiftUI
import FirebaseAuth

struct RegisterUser: View {
  //  @State private var email: String = ""
    @State private var password: String = ""
    
    @State private var isLoginPage: Bool = false
    @State private var alertModel: AlertModel?
    
    @State private var isSuccess: Bool = false
    
    @State private var showCreateProfileSheet: Bool = false
    
    @AppStorage("loggedIn") private var loggedIn: Bool = false
    @AppStorage("email") private var loginEmail: String = ""
    @AppStorage("not-token") private var notToken: String = ""
    
    //@StateObject private var
    
    var body: some View {
        VStack{
            NavigationLink(destination: ContentView(), isActive: $isSuccess){}
                .hidden()
            
            Spacer()
            
            Image("asman_logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
            //.blur(radius: 7)
            
            
            VStack{
                
                
                VStack{
                    Text(isLoginPage ? "Login" : "Sign up")
                        .font(.headline)
                        .padding(.top)
                    
                    HStack(spacing: 0){
                        Image(systemName: "envelope")
                        
                        TextField("email", text: $loginEmail)
                            .padding()
                            .padding(.trailing, 10)
                            .overlay(
                                Image(systemName: "xmark")
                                    .padding(5)
                                    .opacity(loginEmail.isEmpty ? 0 : 1)
                                    .onTapGesture {
                                        UIApplication.shared.endEditing()
                                        loginEmail = ""
                                    }
                                
                                , alignment: .trailing
                            )
                            .disableAutocorrection(true)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                        
                        
                        
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
                            .autocapitalization(.none)
                        
                        
                        
                        
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
                    if isLoginPage{
                        login(password: password)
                        
                    }else{
                        signup(password: password)
                    }
                } label: {
                    Text(isLoginPage ? "Login" : "Register")
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
                    Text(isLoginPage ? "Don't have an account?" : "Already have an account?")
                    
                    Button {
                        //more code here
                        withAnimation {
                            loginEmail = ""
                            password = ""
                            isLoginPage.toggle()
                            
                        }
                    } label: {
                        Text(isLoginPage ? "Register" : "Login")
                    }
                    
                }
                .font(.caption)
                .padding(.top)
                
            }
            
            Spacer()
            Spacer()
            
        }
        .fullScreenCover(isPresented: $showCreateProfileSheet){
            CreateProfile()
        }
        .alert(item: $alertModel) { alert in
            Alert(title: Text(alert.title), message: Text(alert.message), dismissButton: .cancel())
            
        }
    }
    
    func login(password: String){
        guard !loginEmail.trimmingCharacters(in: .whitespaces).isEmpty && !password.trimmingCharacters(in: .whitespaces).isEmpty else{
            print("fill email and password correctly")
            return
        }
        
        Auth.auth().signIn(withEmail: loginEmail, password: password){ result, error in
            guard error == nil else{
                print("error logging in: \(String(describing: error))")
                alertModel = AlertModel(title: "Error", message: error!.localizedDescription)
                return
            }
            if let result = result{
                print("\nsuccessfully logged in: \(result.user.uid)")
               // loginEmail = email
                loggedIn = true
                isSuccess = true
            }else{
                print("returned nil from login result")
            }
        }
    }
    
    func signup(password: String){
        guard !loginEmail.trimmingCharacters(in: .whitespaces).isEmpty && !password.trimmingCharacters(in: .whitespaces).isEmpty else{
            print("fill email and password correctly")
            return
        }
        
        Auth.auth().createUser(withEmail: loginEmail, password: password) {result, error in
            
            guard error == nil else{
                print("error signing up: \(error)")
                
                alertModel = AlertModel(title: "Error", message: error!.localizedDescription)
                
                return
            }
            
            if let result = result{
                print("\nsuccessfully signed up: \(result.user.uid)")
                showCreateProfileSheet = true
                
                //isSuccess = true
            }else{
                print("returned nil from sign up result")
                
            }
        }
    }
    
}

struct RegisterUser_Previews: PreviewProvider {
    static var previews: some View {
        RegisterUser()
    }
}
