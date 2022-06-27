//
//  ContentView.swift
//  HeadwaySwiftUITestProject
//
//  Created by Ivan Pestov on 06.06.2022.
//

import SwiftUI
import Firebase

struct ContentView: View {
    
    @State private var isLiked = false
    
    var body: some View {
        VStack {
            HeartButton(isLiked: $isLiked)
        }
    }
}

struct HeartButton: View {
    @Binding var isLiked: Bool
    
    private let animationDuration: Double = 0.1
    private var animationScale: CGFloat {
        isLiked ? 0.7 : 1.3
    }
    @State private var animate = false
    
    
    var body: some View {
        
        Button {
            self.animate = true
            DispatchQueue.main.asyncAfter(deadline: .now() + self.animationDuration) {
                self.animate = true
                self.isLiked.toggle()
            }
        } label: {
            Image(systemName: isLiked ? "heart.fill" : "heart")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100)
                .foregroundColor(isLiked ? .red : .gray)
        }
        .scaleEffect(animate ? animationScale : 1)
        .animation(.easeIn(duration: animationDuration))
    }
}

struct ContentViewf_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}
