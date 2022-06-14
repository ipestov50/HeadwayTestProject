//
//  Login.swift
//  HeadwaySwiftUITestProject
//
//  Created by Ivan Pestov on 12.06.2022.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseAuth

struct Login: View {
    
    @State var color    = Color.black.opacity(0.7)
    @State var email    = ""
    @State var pass     = ""
    @State var visible  = false
    @Binding var show   : Bool
    @State var alert    = false
    @State var error    = ""
    @State var provider = OAuthProvider(providerID: "github.com")
    @State var credential : AuthCredential!
  
    
    var body: some View {
        
        
        ZStack {
            
            ZStack(alignment: .topTrailing) {
                
                GeometryReader{_ in
                    
                    VStack {
                        
                        Image("logo")
                        
                        Text("Log in to your account")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(self.color)
                            .padding(.top, 35)
                        
                        TextField("Email", text: self.$email)
                            .autocapitalization(.none)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 4).stroke(self.email != "" ? Color("Color") : self.color, lineWidth: 2))
                            .padding(.top, 25)
                        
                        HStack(spacing: 15) {
                            
                            VStack {
                                
                                if self.visible {
                                    
                                    TextField("Password", text: self.$pass)
                                        .autocapitalization(.none)
                                } else {
                                    
                                    SecureField("Password", text: self.$pass)
                                        .autocapitalization(.none)
                                }
                            }
                            
                            Button(action: {
                                
                                self.visible.toggle()
                                
                            }) {
                                
                                Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(self.color)
                            }
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 4).stroke(self.pass != "" ? Color("Color") : self.color, lineWidth: 2))
                        .padding(.top, 25)
                        
                        HStack {
                            
                            Spacer()
                            
                            Button(action: {
                                
                                self.reset()
                                
                            }) {
                                
                                Text("Forget password")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("Color"))
                            }
                        }
                        .padding(.top, 15)
                        
                        Button(action: {
                            
                            self.verify()
                        }){
                            Text("Log in")
                                .foregroundColor(.white)
                                .padding(.vertical)
                                .frame(width: UIScreen.main.bounds.width - 50)
                        }
                        .background(Color("Color"))
                        .cornerRadius(10)
                        .padding(.top, 10)
                        
                        Button(action: {
                            
                            self.githubSignIn()
                        }){
                            Text("Log in with GitHub")
                                .foregroundColor(.white)
                                .padding(.vertical)
                                .frame(width: UIScreen.main.bounds.width - 50)
                            
                        }
                        .background(.yellow)
                        .cornerRadius(10)
                        .padding(.top, 10)
                        
                    }
                    .padding(.horizontal, 25)
                    
                    
                }
                .offset(y: 70)
                
                
                Button(action: {
                    
                    self.show.toggle()
                    
                }) {
                    Text("Register")
                        .fontWeight(.bold)
                        .foregroundColor(Color("Color"))
                }
                .padding()
            }
            
            if self.alert {
                
                ErrorView(alert: self.$alert, error: self.$error)
            }
            
        }
    }
    
    func verify() {
        
        if self.email != "" && self.pass != "" {
            
            Auth.auth().signIn(withEmail: self.email, password: self.pass) { res, err in
                
                if err != nil {
                    
                    self.error = err!.localizedDescription
                    self.alert.toggle()
                    return
                }
                
                print("success")
                UserDefaults.standard.set(true, forKey: "status")
                NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
            }
            
        } else {
            self.error = "Please fill all the content properly"
            self.alert.toggle()
        }
    }
    
    func reset() {
        
        if self.email != "" {
            
            Auth.auth().sendPasswordReset(withEmail: self.email) { err in
                
                if err != nil {
                    
                    self.error = err!.localizedDescription
                    self.alert.toggle()
                    return
                }
                self.error = "RESET"
                self.alert.toggle()
            }
        }
        else {
            
            self.error = "Email Id is empty"
            self.alert.toggle()
        }
    }
    
    func githubSignIn() {
        
        provider.getCredentialWith(nil) { credential, error in

            if error != nil {
                
                self.error = error!.localizedDescription
                self.alert.toggle()
                return
                
            }
            if self.credential != nil {
                Auth.auth().signIn(with: self.credential!) { authResult, error in
                    if error != nil {
                        self.error = error!.localizedDescription
                        self.alert.toggle()
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

struct LoginPreview: PreviewProvider {
    
    static var previews: some View {
        WelcomeView()
    }
}
