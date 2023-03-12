//
//  FlagImage.swift
//  GuessTheFlag
//
//  Created by Brandon Coston on 2/28/23.
//

import SwiftUI

struct FlagImage: View {
    var imageName: String
    var body: some View {
        Image(imageName)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}

struct FlagImage_Previews: PreviewProvider {
    static var previews: some View {
        FlagImage(imageName: "US")
    }
}
