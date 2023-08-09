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
            VStack(spacing: 5) {
                Capsule()
                    .fill(showMenu ? .white : .black)
                    .frame(width: 30, height: 3)
                    .rotationEffect(.init(degrees: showMenu ? -50 : 0))
                    .offset(x: showMenu ? 2 : 0, y: showMenu ? 9 : 0)
                
                VStack(spacing: 5) {
                    Capsule()
                        .fill(showMenu ? .white : .black)
                        .frame(width: 30, height: 3)
                    
                    Capsule()
                        .fill(showMenu ? .white : .black)
                        .frame(width: 30, height: 3)
                        .offset(y: showMenu ? -8 : 0)
                }
                .rotationEffect(.init(degrees: showMenu ? 50 : 0))
            }
        }
        .padding()
    }
}


struct MenuButtons_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
