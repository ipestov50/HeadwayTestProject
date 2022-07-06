//
//  FavoritesDetailView.swift
//  HeadwaySwiftUITestProject
//
//  Created by Ivan Pestov on 24.06.2022.
//

import SwiftUI

struct FavoritesDetailView: View {
    
    @Binding var isShowingDetail: Bool
    
    let repository: Repository?
    
        var body: some View {
            VStack {
                VStack {
                    Text(repository?.name ?? "no name")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding()
                    
                    Text(repository?.description ?? "no description")
                        .multilineTextAlignment(.center)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .offset(y: -20)
                        .padding()
                    
                    HStack(spacing: 20) {
                        FavoritesInfo(title: "Username", value: repository?.owner.login ?? "-")
                        FavoritesInfo(title: "Language", value: repository?.language ?? "-")
                        FavoritesInfo(title: "Visibility", value: repository?.visibility ?? "-")
                    }
                }
                
                Spacer()
                
//                TPButton()
                
                VStack {
                    Text("Updated at:") // работаю над датой...
                        .bold()
                        .font(.caption)
                    
//                    Text("\(repository?.updated_at)")
                        .foregroundColor(.secondary)
                        .fontWeight(.light)
                        .italic()
                    
                }
                .padding(.bottom, 10)
                
            }
            .frame(width: 355, height: 385)
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(radius: 40)
            .overlay(Button {
                isShowingDetail = false
            } label: {
                XDismissButton()
            }, alignment: .topTrailing)
        }
    }

struct FavoritesDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesDetailView(isShowingDetail: .constant(true), repository: Repository(id: 0, node_id: "", name: "react-native", html_url: "", description: "UIApplicationgetKeyboardDevicePropertiesForSenderID:shouldUpdate:usingSyntheticEvent:], failed to fetch device property for senderID (778835616971358211) use primary keyboard info instead.", visibility: "private", language: "Java-Script", updated_at: "29 apr.", owner: Owner(login: "hello"), isLiked: true, isSeen: true))
    }
}

struct FavoritesInfo: View {
    
    let title: String
    let value: String
    
    var body: some View {
        
        VStack {
            Text(title)
                .bold()
                .font(.caption)
            
            Text(value)
                .foregroundColor(.secondary)
                .fontWeight(.semibold)
                .italic()
        }
    }
}
