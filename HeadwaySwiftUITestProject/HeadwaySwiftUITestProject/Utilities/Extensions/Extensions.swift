//
//  Extensions.swift
//  SwiftUITestProject
//
//  Created by Ivan Pestov on 07.06.2022.
//

import SwiftUI

// MARK: - Custom View Property Extensions
extension View {
    // MARK: - Building a Custom Modifier for Custom Popup navigation View
    func popupNavigationView<Content: View>(horizontalPadding: CGFloat = 40 ,show: Binding<Bool>,@ViewBuilder content: @escaping ()->Content)-> some View{
        
        return self
            .overlay {
                if show.wrappedValue {
                    // MARK: - Geometry Reader for reading Container Frame
                    GeometryReader { proxy in
                        
                        let size = proxy.size
                        
                        NavigationView {
                            content()
                        }
                        .frame(width: size.width - horizontalPadding, height: size.height / 1.7, alignment: .center)
                        // Corner Radius
                        .cornerRadius(15)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    }
                }
            }
    }
}

// MARK: - Color Extensions
extension Color {
    static let brandPrimary = Color("brandPrimary")
}

extension UIColor {
    static let brandPrimary = UIColor(named: "brandPrimary")
}
