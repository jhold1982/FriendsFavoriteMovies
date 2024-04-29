//
//  FilteredMovieListView.swift
//  FriendsFavoriteMovies
//
//  Created by Justin Hold on 4/29/24.
//

import SwiftUI

struct FilteredMovieListView: View {
	
	// MARK: - PROPERTIES
	@State private var searchText = ""
	
	
	// MARK: - VIEW BODY
    var body: some View {
		
		NavigationSplitView {
			MovieListView(titleFilter: searchText)
				.searchable(text: $searchText)
		} detail: {
			Text("Select a Movie")
				.navigationTitle("Movie")
		}
    }
}

#Preview {
    FilteredMovieListView()
		.modelContainer(SampleData.shared.modelContainer)
}
