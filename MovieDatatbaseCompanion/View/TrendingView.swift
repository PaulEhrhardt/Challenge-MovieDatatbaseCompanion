//
//  TrendingView.swift
//  MovieDatatbaseCompanion
//
//  Created by Paul Ehrhardt on 30/11/24.
//

import SwiftUI


// MARK: - TrendingView -

struct TrendingView: View {
    
    
    // MARK: - Properties
    
    @State var viewModel = TrendingViewModel()

    
    // MARK: - Lifecycle
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(viewModel.movies, id: \.self) { movie in
                    MovieView(movie: movie)
                }
                switch viewModel.state {
                case .loading:
                    LoadingView()
                case .initial, .nextPage:
                    LoadingView()
                        .onAppear {
                            Task {
                                await viewModel.loadTrendingMovies()
                            }
                        }
                }
            }
        }
    }
}


// MARK: - Preview -

#Preview {
    TrendingView()
}
