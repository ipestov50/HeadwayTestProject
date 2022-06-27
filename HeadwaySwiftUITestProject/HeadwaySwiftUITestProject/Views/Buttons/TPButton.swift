//
//  TPButton.swift
//  HeadwaySwiftUITestProject
//
//  Created by Ivan Pestov on 27.06.2022.
//

// *TP - Test Project =)

import SwiftUI

struct TPButton: View {
    var body: some View {
        Button {
            
        } label: {
            Text("Visit GitHub")
                .font(.title3)
                .fontWeight(.semibold)
                .frame(width: 260, height: 50)
                .foregroundColor(.white)
                .background(Color.yellow)
                .cornerRadius(10)
        }
        .padding(.bottom, 30)
    }
}

struct TPButton_Previews: PreviewProvider {
    static var previews: some View {
        TPButton()
    }
}
