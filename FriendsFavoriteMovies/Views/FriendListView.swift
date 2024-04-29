//
//  FriendListView.swift
//  FriendsFavoriteMovies
//
//  Created by Justin Hold on 4/29/24.
//

import SwiftUI
import SwiftData

struct FriendListView: View {
	
	// MARK: - PROPERTIES
	@Environment(\.modelContext) private var modelContext
	@Query(sort: \Friend.name) private var friends: [Friend]
	
	@State private var newFriend: Friend?
	
	
	// MARK: - VIEW BODY
    var body: some View {
		NavigationSplitView {
			Group {
				if !friends.isEmpty {
					List {
						ForEach(friends) { friend in
							NavigationLink {
								FriendsDetailView(friend: friend)
							} label: {
								Text(friend.name)
							}
						}
						.onDelete(perform: deleteFriends)
					}
				} else {
					ContentUnavailableView {
						Label("No Friends", systemImage: "person.and.person")
					}
				}
			}
			.navigationTitle("Friends")
			.toolbar {
				ToolbarItem(placement: .topBarTrailing) {
					EditButton()
				}
				ToolbarItem {
					Button(action: addFriend) {
						Label("Add Item", systemImage: "plus")
					}
				}
			}
			.sheet(item: $newFriend) { friend in
				NavigationStack {
					FriendsDetailView(friend: friend, isNew: true)
				}
				.interactiveDismissDisabled()
			}
		} detail: {
			Text("Select a Friend")
				.navigationTitle("Friend")
		}
    }
	
	// MARK: - METHODS
	/// Declares a constant called newItem that is of type Friend with name of empty string
	/// Adds newItem to modelContext
	/// Sets newFriend var to be equal to newItem
	private func addFriend() {
		withAnimation {
			let newItem = Friend(name: "")
			modelContext.insert(newItem)
			newFriend = newItem
		}
	}
	
	/// Uses a ForLoop to delete Friends out of Friends Array
	/// - Parameter offsets: checks position of deleted item, resets index of array
	private func deleteFriends(offsets: IndexSet) {
		withAnimation {
			for index in offsets {
				modelContext.delete(friends[index])
			}
		}
	}
}

#Preview {
    FriendListView()
		.modelContainer(SampleData.shared.modelContainer)
}
