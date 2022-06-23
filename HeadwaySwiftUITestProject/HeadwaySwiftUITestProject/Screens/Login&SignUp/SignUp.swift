//
//  SignUp.swift
//  HeadwaySwiftUITestProject
//
//  Created by Ivan Pestov on 12.06.2022.

import SwiftUI
import Firebase

struct SignUp : View {
    
    @StateObject var vm = SignUpViewModel()
    @Binding var show : Bool
    
    var body: some View{
        
        ZStack{
            
            ZStack(alignment: .topLeading) {
                
                GeometryReader{_ in
                    
                    VStack{
                        
                        Image("logo")
                        
                        Text("Register new account")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(vm.color)
                            .padding(.top, 35)
                        
                        TextField("Email", text: $vm.email)
                        .autocapitalization(.none)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 4).stroke(vm.email != "" ? Color("Color") : vm.color,lineWidth: 2))
                        .padding(.top, 25)
                        
                        HStack(spacing: 15){
                            
                            VStack{
                                
                                if vm.visible{
                                    
                                    TextField("Password", text: $vm.pass)
                                    .autocapitalization(.none)
                                }
                                else{
                                    
                                    SecureField("Password", text: $vm.pass)
                                    .autocapitalization(.none)
                                }
                            }
                            
                            Button(action: {
                                
                                vm.visible.toggle()
                                
                            }) {
                                
                                Image(systemName: vm.visible ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(vm.color)
                            }
                            
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 4).stroke(vm.pass != "" ? Color("Color") : vm.color,lineWidth: 2))
                        .padding(.top, 25)
                        
                        HStack(spacing: 15){
                            
                            VStack{
                                
                                if vm.revisible{
                                    
                                    TextField("Re-enter", text: $vm.repass)
                                    .autocapitalization(.none)
                                }
                                else{
                                    
                                    SecureField("Re-enter", text: $vm.repass)
                                    .autocapitalization(.none)
                                }
                            }
                            
                            Button(action: {
                                
                                vm.revisible.toggle()
                                
                            }) {
                                
                                Image(systemName: vm.revisible ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(vm.color)
                            }
                            
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 4).stroke(vm.repass != "" ? Color("Color") : vm.color,lineWidth: 2))
                        .padding(.top, 25)
                        
                        
                        Button(action: {
                            
                            self.register()
                        }) {
                            
                            Text("Register")
                                .foregroundColor(.white)
                                .padding(.vertical)
                                .frame(width: UIScreen.main.bounds.width - 50)
                        }
                        .background(Color("Color"))
                        .cornerRadius(10)
                        .padding(.top, 25)
                    }
                    .padding(.horizontal, 25)
                    
                    Button(action: {
                        
                        self.show.toggle()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.title)
                            .foregroundColor(Color("Color"))
                    }
                    .padding()
                }
            }
            
            if vm.alert{
                
                ErrorView(alert: $vm.alert, error: $vm.error)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
}

struct SignUpPreview: PreviewProvider {
    
    static var previews: some View {
        WelcomeView()
    }
}
