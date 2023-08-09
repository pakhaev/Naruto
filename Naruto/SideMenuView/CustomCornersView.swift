//
//  CustomCornersView.swift
//  Naruto
//
//  Created by Khusain on 08.08.2023.
//

import SwiftUI

struct CustomCornersView: Shape {
    var corners: UIRectCorner
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        
        return Path(path.cgPath)
    }

}

