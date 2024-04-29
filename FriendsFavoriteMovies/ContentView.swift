//
//  ContentView.swift
//  FriendsFavoriteMovies
//
//  Created by Justin Hold on 4/29/24.
//

import SwiftUI

struct ContentView: View {
	
	// MARK: - PROPERTIES
	
	
	// MARK: - VIEW BODY
    var body: some View {
		TabView {
			
			// Tab 1
			MovieListView()
				.tabItem {
					Label("Movies", systemImage: "film.stack")
				}
			
			// Tab 2
			FriendListView()
				.tabItem {
					Label("Friends", systemImage: "person.and.person")
				}
		}
    }
}

#Preview {
    ContentView()
		.modelContainer(SampleData.shared.modelContainer)
}
