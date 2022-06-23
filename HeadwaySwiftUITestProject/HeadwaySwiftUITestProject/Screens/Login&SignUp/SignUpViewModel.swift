//
//  SignUpViewModel.swift
//  HeadwaySwiftUITestProject
//
//  Created by Ivan Pestov on 22.06.2022.
//

import SwiftUI
import Firebase

class SignUpViewModel: ObservableObject {
    
    @Published var color        = Color.black.opacity(0.7)
    @Published var email        = ""
    @Published var pass         = ""
    @Published var repass       = ""
    @Published var visible      = false
    @Published var revisible    = false
    @Published var alert        = false
    @Published var error        = ""
    
}

extension SignUp {
    
    func register(){
        
        if vm.email != ""{
            
            if vm.pass == vm.repass{
                
                Auth.auth().createUser(withEmail: vm.email, password: vm.pass) { (res, err) in
                    
                    if err != nil{
                        
                        vm.error = err!.localizedDescription
                        vm.alert.toggle()
                        return
                    }
                    
                    print("success")
                    
                    UserDefaults.standard.set(true, forKey: "status")
                    NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
                }
            }
            else{
                
                vm.error = "Password mismatch"
                vm.alert.toggle()
            }
        }
        else{
            
            vm.error = "Please fill all the contents properly"
            vm.alert.toggle()
        }
    }
}
