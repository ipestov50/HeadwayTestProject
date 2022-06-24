//
//  FavoritesDetailView.swift
//  HeadwaySwiftUITestProject
//
//  Created by Ivan Pestov on 24.06.2022.
//

import SwiftUI

struct FavoritesDetailView: View {
    
    let repository: Repository?
    @Binding var isShowingDetail: Bool
    
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
                        VStack {
                            Text("Name")
                                .bold()
                                .font(.caption)
                            
                            Text(repository?.login ?? "-")
                                .foregroundColor(.secondary)
                                .fontWeight(.semibold)
                                .italic()
                        }
                        
                        VStack {
                            Text("Language")
                                .bold()
                                .font(.caption)
                            
                            Text(repository?.language ?? "-")
                                .foregroundColor(.secondary)
                                .fontWeight(.semibold)
                                .italic()
                        }
                        
                        VStack {
                            Text("Visibility")
                                .bold()
                                .font(.caption)
                            
                            Text(repository?.visibility ?? "-")
                                .foregroundColor(.secondary)
                                .fontWeight(.semibold)
                                .italic()
                        }
                        
                    }
                    
                }
                
                Spacer()
                
//                Button {
//
//                } label: {
//                    Text("Visit GitHub")
//                        .font(.title3)
//                        .fontWeight(.semibold)
//                        .frame(width: 260, height: 50)
//                        .foregroundColor(.white)
//                        .background(Color.blue)
//                        .cornerRadius(10)
//                }
//                .padding(.bottom, 20)
                
                VStack {
                    Text("Updated at:")
                        .bold()
                        .font(.caption)
                    
                    Text(repository?.updated_at ?? "")
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
                ZStack {
                    Circle()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white)
                        .opacity(0.6)
                    
                    Image(systemName: "xmark")
                        .imageScale(.small)
                        .frame(width: 44, height: 44)
                        .foregroundColor(.black)
                }
            }, alignment: .topTrailing)
        }
    }

struct FavoritesDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesDetailView(repository: Repository(id: 0, node_id: "", name: "react-native", html_url: "", description: "UIApplicationgetKeyboardDevicePropertiesForSenderID:shouldUpdate:usingSyntheticEvent:], failed to fetch device property for senderID (778835616971358211) use primary keyboard info instead.", visibility: "private", language: "Java-Script", updated_at: "29 apr.", login: "GXfelix", isLiked: true, isSeen: true), isShowingDetail: .constant(true))
    }
}
