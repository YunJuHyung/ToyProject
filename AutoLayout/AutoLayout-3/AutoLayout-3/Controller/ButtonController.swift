//
//  ButtonController.swift
//  AutoLayout-3
//
//  Created by 윤주형 on 5/31/24.
//

import SwiftUI

struct ButtonController: View {
    let name: String
    let image: String
    
    var body: some View {
       RoundedRectangle(cornerRadius: 20)
            .fill(Color.white)
            .frame(height: 50)
            .overlay(HStack{
                Image(image)
                Text(name)
                    .font(.system(size: 24))
            })
            .padding(.all)
        
    }
}

#Preview {
    ButtonController(name: "직방", image: "Logo")
}
