//
//  TabButtonView.swift
//  Naruto
//
//  Created by Khusain on 08.08.2023.
//

import SwiftUI

struct TabButtonView: View {
    @Binding var selectedTab: Int
    
    let page: Int
    let image: String
    let title: String
    let animation: Namespace.ID
    
    var body: some View {
        Button {
            withAnimation(.spring()) {
                selectedTab = page
            }
        } label: {
            HStack(spacing: 15) {
                Image(image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                
                Text(title)
            }
            .foregroundColor(selectedTab == page ? .blue : .white)
            .padding(.vertical, 12)
            .padding(.horizontal, 10)
            .frame(maxWidth: getRect().width - 170, alignment: .leading)
            .background(
                
                ZStack {
                    if selectedTab == page {
                        Color.white
                            .opacity(selectedTab == page ? 1 : 0)
                            .clipShape(CustomCornersView(corners: [.topRight, .bottomRight], radius: 12))
                            .matchedGeometryEffect(id: "TAB", in: animation)
                    }
                }
                
                
            )
        }

    }
}

struct TabButtonView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
