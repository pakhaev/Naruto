//
//  MenuButtons.swift
//  Naruto
//
//  Created by Khusain on 09.08.2023.
//

import SwiftUI


struct MenuButtons: View {
    @Binding var showMenu: Bool
    
    var body: some View {
        Button {
            withAnimation(.spring()) {
                showMenu.toggle()
            }
        } label: {
            VStack(spacing: 7) {
                Capsule()
                    .fill(showMenu ? .white : .black)
                    .frame(width: 30, height: 3)
                    .rotationEffect(.init(degrees: showMenu ? -50 : 0))
                    .offset(x: showMenu ? 4 : 0, y: showMenu ? 11 : 0)
                
                VStack(spacing: 7) {
                    Capsule()
                        .fill(showMenu ? .white : .black)
                        .frame(width: 30, height: 3)
                    
                    Capsule()
                        .fill(showMenu ? .white : .black)
                        .frame(width: 30, height: 3)
                        .offset(y: showMenu ? -10 : 0)
                }
                .rotationEffect(.init(degrees: showMenu ? 50 : 0))
            }
        }
        .padding(.top, 0)
        .padding(.leading, 16)
    }
}


struct MenuButtons_Previews: PreviewProvider {
    static var previews: some View {
        NarutoView()
    }
}
