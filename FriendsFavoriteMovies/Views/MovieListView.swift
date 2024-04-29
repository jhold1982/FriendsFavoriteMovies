//
//  MovieListView.swift
//  FriendsFavoriteMovies
//
//  Created by Justin Hold on 4/26/24.
//

import SwiftUI
import SwiftData

struct MovieListView: View {
	
	// MARK: - PROPERTIES
    @Environment(\.modelContext) private var modelContext
	@Query private var movies: [Movie]

	@State private var newMovie: Movie?
	
	init(titleFilter: String = "") {
		let predicate = #Predicate<Movie> { movie in
			titleFilter.isEmpty || movie.title.localizedStandardContains(titleFilter)
		}
		
		_movies = Query(filter: predicate, sort: \Movie.title)
	}
	
	// MARK: - VIEW BODY
    var body: some View {
		
		Group {
			if !movies.isEmpty {
				List {
					ForEach(movies) { movie in
						NavigationLink {
							MovieDetailView(movie: movie)
						} label: {
							Text(movie.title)
						}
					}
					.onDelete(perform: deleteItems)
				}
			} else {
				ContentUnavailableView {
					Label("No Movies", systemImage: "film.stack")
				}
			}
		}
		.navigationTitle("Movies")
		.toolbar {
			ToolbarItem(placement: .navigationBarTrailing) {
				EditButton()
			}
			ToolbarItem {
				Button(action: addMovie) {
					Label("Add Item", systemImage: "plus")
				}
			}
		}
		.sheet(item: $newMovie) { movie in
			NavigationStack {
				MovieDetailView(movie: SampleData.shared.movie)
			}
			.interactiveDismissDisabled()
		}
    }

	// MARK: - FUNCTIONS
	/// Function to add movie to into modelContext then into View
    private func addMovie() {
        withAnimation {
			let newItem = Movie(title: "", releaseDate: .now)
            modelContext.insert(newItem)
			newMovie = newItem
        }
    }
	
	/// Function to delete items from View and in the array
	/// - Parameter offsets: finds position in array and resets when item is removed
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(movies[index])
            }
        }
    }
}

#Preview {
	NavigationStack {
		MovieListView()
			.modelContainer(SampleData.shared.modelContainer)
	}
}

#Preview("Empty List") {
	NavigationStack {
		MovieListView()
			.modelContainer(for: Movie.self, inMemory: true)
	}
}

#Preview("Filtered") {
	NavigationStack {
		MovieListView(titleFilter: "tr")
			.modelContainer(SampleData.shared.modelContainer)
	}
}
