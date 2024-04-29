//
//  Friend.swift
//  FriendsFavoriteMovies
//
//  Created by Justin Hold on 4/29/24.
//

import Foundation
import SwiftData

@Model
final class Friend {
	var name: String
	var favoriteMovie: Movie?
	
	init(name: String) {
		self.name = name
	}
	
	static let sampleData = [
		Friend(name: "Lindsay"),
		Friend(name: "Oliver"),
		Friend(name: "Marigold"),
		Friend(name: "Lucy"),
		Friend(name: "Harley")
	]
}
