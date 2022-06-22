//
//  LoginViewModel.swift
//  HeadwaySwiftUITestProject
//
//  Created by Ivan Pestov on 22.06.2022.
//

import SwiftUI
import Firebase
import FirebaseAuth

class LoginViewModel: ObservableObject {
    
    @Published var color    = Color.black.opacity(0.7)
    @Published var email    = ""
    @Published var pass     = ""
    @Published var visible  = false
//    @Published var show     = false
    @Published var alert    = false
    @Published var error    = ""
    
}


// MARK: - Methods 
extension Login {
    
    func verify() {
        
        if viewModel.email != "" && viewModel.pass != "" {
            
            Auth.auth().signIn(withEmail: viewModel.email, password: viewModel.pass) { res, err in
                
                if err != nil {
                    
                    viewModel.error = err!.localizedDescription
                    viewModel.alert.toggle()
                    return
                }
                
                print("success")
                UserDefaults.standard.set(true, forKey: "status")
                NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
            }
            
        } else {
            viewModel.error = "Please fill all the content properly"
            viewModel.alert.toggle()
        }
    }
    
    func reset() {
        
        if viewModel.email != "" {
            
            Auth.auth().sendPasswordReset(withEmail: viewModel.email) { err in
                
                if err != nil {
                    
                    viewModel.error = err!.localizedDescription
                    viewModel.alert.toggle()
                    return
                }
                viewModel.error = "RESET"
                viewModel.alert.toggle()
            }
        }
        else {
            
            viewModel.error = "Email Id is empty"
            viewModel.alert.toggle()
        }
    }
    
    func githubSignIn() {
        
        provider.getCredentialWith(nil) { credential, error in

            if error != nil {
                
                viewModel.error = error!.localizedDescription
                viewModel.alert.toggle()
                return
                
            }
            if self.credential != nil {
                Auth.auth().signIn(with: self.credential!) { authResult, error in
                    if error != nil {
                        viewModel.error = error!.localizedDescription
                        viewModel.alert.toggle()
                        return
                    }
                    guard authResult?.credential is OAuthCredential else { return }
                }
            }
            print("success")
            UserDefaults.standard.set(true, forKey: "status")
            NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
        }
    }
    
}
