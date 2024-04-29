//
//  FriendDetailView.swift
//  FriendsFavoriteMovies
//
//  Created by Justin Hold on 4/29/24.
//

import SwiftUI

struct FriendDetailView: View {
	
	// MARK: - PROPERTIES
	@Bindable var friend: Friend
	
	@Environment(\.dismiss) private var dismiss
	@Environment(\.modelContext) private var modelContext
	
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
