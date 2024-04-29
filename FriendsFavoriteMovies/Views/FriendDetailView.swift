//
//  FriendDetailView.swift
//  FriendsFavoriteMovies
//
//  Created by Justin Hold on 4/29/24.
//

import SwiftUI
import SwiftData

struct FriendDetailView: View {
	
	// MARK: - PROPERTIES
	@Bindable var friend: Friend
	
	@Environment(\.dismiss) private var dismiss
	@Environment(\.modelContext) private var modelContext
	
	@Query(sort: \Movie.title) private var movies: [Movie]
	
	let isNew: Bool
	
	init(friend: Friend, isNew: Bool = false) {
		self.friend = friend
		self.isNew = isNew
	}
	
	// MARK: - VIEW BODY
    var body: some View {
		Form {
			
			TextField("Name", text: $friend.name)
				.autocorrectionDisabled()
			
			Picker("Favorite Movie", selection: $friend.favoriteMovie) {
				
				Text("None")
					.tag(nil as Movie?)
				
				ForEach(movies) { movie in
					Text(movie.title)
						.tag(movie as Movie?)
				}
			}
			.pickerStyle(.menu)
		}
		.navigationTitle(isNew ? "New Friend" : "Friend")
		.toolbar {
			if isNew {
				ToolbarItem(placement: .confirmationAction) {
					Button("Done") {
						dismiss()
					}
				}
				ToolbarItem(placement: .cancellationAction) {
					Button("Cancel") {
						modelContext.delete(friend)
						dismiss()
					}
				}
			}
		}
    }
	
	// MARK: - METHODS
	
}

#Preview {
	NavigationStack {
		FriendDetailView(friend: SampleData.shared.friend)
	}
	.modelContainer(SampleData.shared.modelContainer)
}

#Preview("New Friend") {
	NavigationStack {
		FriendDetailView(friend: SampleData.shared.friend, isNew: true)
			.navigationBarTitleDisplayMode(.inline)
	}
	.modelContainer(SampleData.shared.modelContainer)
}
