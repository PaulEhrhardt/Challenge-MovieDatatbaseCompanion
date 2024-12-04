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

    let columns = [GridItem(.adaptive(minimum: 300))]


    // MARK: - Lifecycle
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: .bigSpace) {
                ForEach(viewModel.movies, id: \.self) { movie in
                    FilmView(item: movie.asFilmItem())
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
                case .failure:
                    Text("Something went wrong, please try again.")
                        .foregroundColor(Color(uiColor: .tertiaryLabel))
                        .padding(.contentSpace)
                }
            }
            .padding(.top, .bigSpace)
        }
    }
}


// MARK: - Preview -

#Preview {
    TrendingView()
}
