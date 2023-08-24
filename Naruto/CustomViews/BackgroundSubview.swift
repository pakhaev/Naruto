//
//  BackgroundSubview.swift
//  Naruto
//
//  Created by Khusain on 10.08.2023.
//

import SwiftUI

struct BackgroundSubview: View {
    let showMenu: Bool
    let xOffset: CGFloat
    let verticalPadding: CGFloat
    
    
    var body: some View {
        Color("YellowLight")
            .opacity(0.5)
            .cornerRadius(showMenu ? 15 : 0)
            .shadow(color: .black.opacity(0.07), radius: 5, x: -5, y: 0)
            .offset(x: showMenu ? xOffset : 0)
            .padding(.vertical, verticalPadding)
    }
}

struct BackgroundSubview_Previews: PreviewProvider {
    static var previews: some View {
        NarutoView()
    }
}
