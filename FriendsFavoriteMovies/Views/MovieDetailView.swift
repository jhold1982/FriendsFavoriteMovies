//
//  MovieDetailView.swift
//  FriendsFavoriteMovies
//
//  Created by Justin Hold on 4/26/24.
//

import SwiftUI

struct MovieDetailView: View {
	
	// MARK: - PROPERTIES
	@Bindable var movie: Movie
	@Environment(\.dismiss) private var dismiss
	@Environment(\.modelContext) private var modelContext
	
	let isNew: Bool
	
	init(movie: Movie, isNew: Bool = false) {
		self.movie = movie
		self.isNew = isNew
	}
	
	var sortedFriends: [Friend] {
		movie.favoritedBy.sorted { first, second in
			first.name < second.name
		}
	}
	
	// MARK: - VIEW BODY
    var body: some View {
		Form {
			
			TextField("Movie Title", text: $movie.title)
			
			DatePicker(
				"Release Date",
				selection: $movie.releaseDate,
				displayedComponents: .date
			)
			
			if !movie.favoritedBy.isEmpty {
				Section("Favorited by:") {
					ForEach(sortedFriends) { friend in
						Text(friend.name)
					}
				}
			}
			
			
		}
		.navigationTitle(isNew ? "New Movie" : "Movie")
		.toolbar {
			if isNew {
				ToolbarItem(placement: .confirmationAction) {
					Button("Done") {
						dismiss()
					}
				}
			}
			ToolbarItem(placement: .cancellationAction) {
				Button("Cancel") {
					modelContext.delete(movie)
					dismiss()
				}
			}
		}
		
    }
}

#Preview {
	NavigationStack {
		MovieDetailView(movie: SampleData.shared.movie)
	}
	.modelContainer(SampleData.shared.modelContainer)
}

#Preview("New Movie") {
	NavigationStack {
		MovieDetailView(movie: SampleData.shared.movie, isNew: true)
			.navigationBarTitleDisplayMode(.inline)
	}
	.modelContainer(SampleData.shared.modelContainer)
}
