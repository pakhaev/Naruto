//
//  LinearGradientView.swift
//  Naruto
//
//  Created by Khusain on 07.09.2023.
//

import SwiftUI

struct LinearGradientView: View {
    
    let topColorName: String
    let bottomColorName: String
    let startPoint: UnitPoint
    let endPoint: UnitPoint
    
    var body: some View {
        LinearGradient(
            gradient: Gradient(
                colors: [Color(topColorName), Color(bottomColorName)]
            ),
            startPoint: startPoint,
            endPoint: endPoint
        )
        .ignoresSafeArea()
    }
}

struct LinearGradientView_Previews: PreviewProvider {
    static var previews: some View {
        LinearGradientView(
            topColorName: "Yellow",
            bottomColorName: "Orange",
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}
