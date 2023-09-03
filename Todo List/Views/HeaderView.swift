//
//  HeaderView.swift
//  Todo List
//
//  Created by Hussain on 02/09/23.
//

import SwiftUI

struct HeaderView: View {
    
    
    let title : String
    let subtitle : String
    let rotation : Double
    let background : Color
    
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerSize: CGSize())
                .foregroundColor(background)
                .rotationEffect(Angle(degrees: rotation))
                
            VStack {
                Text(title)
                    .font(.system(size : 50))
                    .foregroundColor(Color.white)
                    .bold()
                Text(subtitle)
                    .font(.system(size : 30))
                    .foregroundColor(Color.white)
            }
            .padding(.top,50)
        }
        .frame(width : UIScreen.main.bounds.width * 3,
               height :     350)
        .offset(y : -150)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(title: "Title", subtitle: "Subtitle", rotation: -15, background: Color.pink)
    }
}
