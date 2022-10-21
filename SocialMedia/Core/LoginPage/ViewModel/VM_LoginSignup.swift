//
//  VM_LoginSignup.swift
//  SocialMedia
//
//  Created by Belli's MacBook on 21/10/2022.
//

import Foundation
import FirebaseAuth


class VM_LoginSignup: ObservableObject{
    
    
    func login(email: String, password: String){
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty && !password.trimmingCharacters(in: .whitespaces).isEmpty else{
            print("fill email and password correctly")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password){result, error in
            guard error == nil else{
                print("error logging in: \(error)")
                return
            }
            if let result = result{
                print("\nsuccessfully logged in: \(result.user.uid)")
            }else{
                print("returned nil from login result")

            }
        }
    }
    
    func signup(email: String, password: String){
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty && !password.trimmingCharacters(in: .whitespaces).isEmpty else{
            print("fill email and password correctly")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            guard error == nil else{
                print("error signing up: \(error)")
                return
            }
            
            if let result = result{
                print("\nsuccessfully signed up: \(result.user.uid)")
            }else{
                print("returned nil from sign up result")

            }
        }
    }
}
