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
    
    @Binding var show   : Bool
    @State var provider = OAuthProvider(providerID: "github.com")
    @State var credential : AuthCredential!
    
    @StateObject var viewModel = LoginViewModel()
  
    
    var body: some View {
        
        
        ZStack {
            
            ZStack(alignment: .topTrailing) {
                
                GeometryReader{_ in
                    
                    VStack {
                        
                        Image("logo")
                        
                        Text("Log in to your account")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(viewModel.color)
                            .padding(.top, 35)
                        
                        TextField("Email", text: $viewModel.email)
                            .autocapitalization(.none)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 4).stroke(viewModel.email != "" ? Color("Color") : viewModel.color, lineWidth: 2))
                            .padding(.top, 25)
                        
                        HStack(spacing: 15) {
                            
                            VStack {
                                
                                if viewModel.visible {
                                    
                                    TextField("Password", text: $viewModel.pass)
                                        .autocapitalization(.none)
                                } else {
                                    
                                    SecureField("Password", text: $viewModel.pass)
                                        .autocapitalization(.none)
                                }
                            }
                            
                            Button(action: {
                                
                                viewModel.visible.toggle()
                                
                            }) {
                                
                                Image(systemName: viewModel.visible ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(viewModel.color)
                            }
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 4).stroke(viewModel.pass != "" ? Color("Color") : viewModel.color, lineWidth: 2))
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
                            
                            githubSignIn()
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
            
            if viewModel.alert {
                
                ErrorView(alert: $viewModel.alert, error: $viewModel.error)
            }
            
        }
    }
}

struct LoginPreview: PreviewProvider {
    
    static var previews: some View {
        WelcomeView()
    }
}
