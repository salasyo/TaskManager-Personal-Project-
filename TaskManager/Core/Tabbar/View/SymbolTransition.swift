//
//  SymbolTransition.swift
//  TaskManager
//
//  Created by Obi on 9/24/23.
//

import SwiftUI

struct SymbolTransition: View {
    
    @State private var sfImage: String = "house.fill"
    @State private var sfCount: Int = 1

    var body: some View {
        VStack {
            Image(systemName: sfImage)
                .font(.largeTitle.bold())
            
            Button(action: {
                let images: [String] = [ "suit.heart.fill", "iphone", "macbook", "person.circle.fill", "gearshape"]
                withAnimation(.bouncy) {
                    sfCount += 1
                    sfImage = images[sfCount % images.count]
                }
            }, label: {
                Text("Change Image")
            })
        }
    }
}

#Preview {
    SymbolTransition()
}
