//
//  WelcomeView.swift
//  HeadwaySwiftUITestProject
//
//  Created by Ivan Pestov on 12.06.2022.
//

import Foundation
import SwiftUI

struct WelcomeView: View {
    @State var show     = false
    @State var status   = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                if self.status {
//                    Homescreen()
                    MainTabView()
                }
                else {
                    ZStack {
                        NavigationLink(destination: SignUp(show: self.$show), isActive: self.$show) {
                            
                            Text("")
                        }
                        .hidden()
                        
                        Login(show: $show)
                    }
                }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .onAppear {
                
                NotificationCenter.default.addObserver(forName: NSNotification.Name("status"), object: nil, queue: .main) { (_) in
                    
                    self.status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
                }
            }
        }
    }
}
