//
//  RoundButtonAnimationView.swift
//  FetchApp (iOS)
//
//  Created by Saad Ata on 2/19/23.
//

import SwiftUI

struct RoundButtonAnimationView: View {
    
    @Binding var isAnimating: Bool
    
    var body: some View {
        
        Circle()
            .stroke(lineWidth: 6.0)
            .scale(isAnimating ? 1.0 : 0.0)
            .opacity(isAnimating ? 0.0 : 1.0)
        
    }
}

struct RoundButtonAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        RoundButtonAnimationView(isAnimating: .constant(false))
    }
}
