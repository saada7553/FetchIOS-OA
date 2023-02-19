//
//  RoundButtonView.swift
//  FetchApp (iOS)
//
//  Created by Saad Ata on 2/19/23.
//
import SwiftUI


// Generic View for a round button
struct RoundButtonView: View {
    
    // MARK: PROPERTIES
    let imageName: String
    let colorStr: Color
    
    // MARK: BODY
    var body: some View {
        
        Image(systemName: imageName)
            .font(.headline)
            .foregroundColor(colorStr)
            .frame(width: 50, height: 50)
            .background(
                Circle()
                    .foregroundColor(.white)
            )
            .shadow(color: .black.opacity(0.30), radius: 10, x: 0, y: 0)
    }
}
    
    // MARK: PREVIEW
struct RoundButtonView_Previews: PreviewProvider {
    static var previews: some View {
        RoundButtonView(imageName: "plus", colorStr: .orange)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
