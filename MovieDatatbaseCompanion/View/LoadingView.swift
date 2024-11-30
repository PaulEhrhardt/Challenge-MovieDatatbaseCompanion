//
//  LoadingView.swift
//  MovieDatatbaseCompanion
//
//  Created by Paul Ehrhardt on 30/11/24.
//

import SwiftUI


// MARK: - LoadingView -

struct LoadingView: View {
    
    
    // MARK: - Lifecycle
    
    let size: CGSize = CGSize(width: 300, height: 300)
    
    
    // MARK: - Lifecycle
    
    var body: some View {
        VStack {
            ProgressView()
                .progressViewStyle(.circular)
                .scaleEffect(3.0)
        }
        .frame(minWidth: size.width, minHeight: size.height)
        .background(Color(UIColor.systemGray6))
    }
}


// MARK: - Preview -

#Preview {
    LoadingView()
}
