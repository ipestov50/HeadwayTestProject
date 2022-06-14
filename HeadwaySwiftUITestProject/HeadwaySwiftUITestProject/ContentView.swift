//
//  ContentView.swift
//  HeadwaySwiftUITestProject
//
//  Created by Ivan Pestov on 06.06.2022.
//

import SwiftUI
import Firebase

struct ContentView: View {
    
    var body: some View {
        
        NavigationView {
            Home()
                .preferredColorScheme(.dark)
                .navigationTitle("Repositories")
        }
    }
}

struct ContentView_Previews: PreviewProvider {    
    static var previews: some View {
        MainTabView()
    }
}

struct MainTabView: View { // Home

    @State var selectedTab = "house"
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            
            Color("TabBG")
                .ignoresSafeArea()
            
            // Custom Tab Bar...
            CustomTabBar(selectedTab: $selectedTab)
            // Home with Search
            Home()

        }
    }
}

struct CustomTabBar: View {
    
    @Binding var selectedTab: String
    
    // Storing Each Tab Midpoints to animate it in future...
    @State var tabPoints : [CGFloat] = []
    
    var body: some View {
        HStack(spacing: 0) {
            // Tab Bar Buttons
            TabBarButton(image: "magnifyingglass.circle", selectedTab: $selectedTab, tabPoints: $tabPoints)
            TabBarButton(image: "suit.heart", selectedTab: $selectedTab, tabPoints: $tabPoints)
            
        }
        .padding()
        .background(
            Color.blue
                .clipShape(TabCurve(tabPoint: getCurvePoint()))
        )
        .cornerRadius(30)
        .padding(.horizontal)
    }
    
    // extracting point
    func getCurvePoint() -> CGFloat {
        // if tabpoint is empty...
        if tabPoints.isEmpty {
            return 10
        } else {
            switch selectedTab {
            case "magnifyingglass.circle":
                return tabPoints[0]
            default:
                return tabPoints[1]
            }
        }
    }
}

struct TabBarButton: View {
    
    var image: String
    @Binding var selectedTab: String
    @Binding var tabPoints: [CGFloat]
    var body: some View {
        
        // For getting mid Point of each button for curve Animation...
        GeometryReader { reader -> AnyView in
            
            // extracting MidPoint and Storing...
            let midX = reader.frame(in: .global).midX
            
            DispatchQueue.main.async {
                
                if tabPoints.count <= 2 {
                    tabPoints.append(midX)
                }
            }
            
            return AnyView (
                Button(action: {
                    // changing tab...
                    // sping animation...
                    withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.5, blendDuration: 0.5)) {
                        selectedTab = image
                    }
                    
                }) {
                    
                    // filling the color if its selected
                    Image(systemName: "\(image)\(selectedTab == image ? ".fill" : "")")
                        .font(.system(size: 25, weight: .semibold))
                        .foregroundColor(Color("TabSelected"))
                    // Lifting View...
                    // if its selected
                        .offset(y: selectedTab == image ? -10 : 0)
                }
                // Max Frame...
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            )
        }
        // maxHeight
        .frame(height: 50)
    }
}

struct TabCurve: Shape {
    
    var tabPoint: CGFloat
    
    // animating path...
    var animatableData: CGFloat {
        get { return tabPoint }
        set { tabPoint = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        
        return Path { path in
            
            // Draving Curve Path...
            path.move(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            
            let mid = tabPoint
            
            path.move(to: CGPoint(x: mid - 40, y: rect.height))
            
            let to = CGPoint(x: mid, y: rect.height - 20)
            let control1 = CGPoint(x: mid - 15, y: rect.height)
            let control2 = CGPoint(x: mid - 15, y: rect.height - 20)
            
            let to1 = CGPoint(x: mid + 40, y: rect.height)
            let control3 = CGPoint(x: mid + 15, y: rect.height - 20)
            let control4 = CGPoint(x: mid + 15, y: rect.height)
            
            path.addCurve(to: to, control1: control1, control2: control2)
            
            path.addCurve(to: to1, control1: control3, control2: control4)
        }
    }
}

struct TabCurve_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}

