//
//  CCResiableSquareImage.swift
//  Notes App
//
//  Created by Simran Preet Singh Narang on 2022-01-07.
//

import SwiftUI

struct CCResizableSquareImage: View {
    
    private var image: Image
    private var size: CGFloat
    
    init(_ name: String, size: CGFloat) {
        self.image = Image(name)
        self.size = size
    }
    
    init(systemName: String, size: CGFloat) {
        self.image = Image(systemName: systemName)
        self.size = size
    }
    
    var body: some View {
        image
            .resizable()
            .frame(width: size, height: size)
    }
}

struct CCResiableSquareImage_Previews: PreviewProvider {
    static var previews: some View {
        CCResizableSquareImage("", size: 150)
    }
}
