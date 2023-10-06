//
//  SplashScreenView.swift
//  Naruto
//
//  Created by Khusain on 06.09.2023.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
            if isActive {
                NarutoView()
            } else {
                ZStack {
                    LinearGradientView(
                        topColorName: "Yellow",
                        bottomColorName: "Orange",
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    
                    VStack {
                        VStack {
                            Image("logo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                                .cornerRadius(100)
                            Text("NarutoWiki")
                                .font(.title)
                                .bold()
                                .foregroundColor(.black)
                                
                        }
                        .scaleEffect(size)
                        .opacity(opacity)
                        .onAppear {
                            withAnimation(.easeIn(duration: 1.2)) {
                                size = 0.9
                                opacity = 1.00
                            }
                        }
                    }
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            withAnimation {
                                isActive = true
                            }
                        }
                }
                }
            }
        }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
