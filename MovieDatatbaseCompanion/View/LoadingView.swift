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
    
    var body: some View {
        VStack {
            ProgressView()
                .progressViewStyle(.circular)
                .scaleEffect(2.0)
                .padding(.vertical, .bigSpace)
        }
        .frame(minWidth: 300)
    }
}


// MARK: - Preview -

#Preview {
    LoadingView()
}
