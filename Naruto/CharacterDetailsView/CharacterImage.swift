//
//  CharacterImage.swift
//  Naruto
//
//  Created by Khusain on 31.07.2023.
//

import SwiftUI
import Kingfisher

struct CharacterImage: View {
    let imageURL: URL?
    let imageSize: CGSize
    let cornerRadius: CGFloat
    let shadowIsOn: Bool
    
    var body: some View {
        KFImage(imageURL)
            .placeholder{
                ProgressView().progressViewStyle(CircularProgressViewStyle(tint: Color(.gray)))
            }
            .onFailureImage(UIImage(named: "defaultImage"))
            .cacheOriginalImage()
            .scaleFactor(1)
            .fade(duration: 0.25)
            .resizable()
            .frame(width: imageSize.width, height: imageSize.height)
            .cornerRadius(cornerRadius)
            .shadow(radius: shadowIsOn ? 10 : 0)
    }
}


struct CharacterImage_Previews: PreviewProvider {
    static var previews: some View {
        CharacterImage(
            imageURL: URL(string: "https://static.wikia.nocookie.net/naruto/images/e/e6/Ten-Tails_emerges.png")!,
            imageSize: CGSize(width: 200, height: 200),
            cornerRadius: 10,
            shadowIsOn: true
        )
    }
}
