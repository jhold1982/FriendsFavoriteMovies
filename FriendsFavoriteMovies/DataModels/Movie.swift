//
//  Movie.swift
//  FriendsFavoriteMovies
//
//  Created by Justin Hold on 4/26/24.
//

import Foundation
import SwiftData

@Model
final class Movie {
	var title: String
    var releaseDate: Date
    
	init(title: String, releaseDate: Date) {
		self.title = title
		self.releaseDate = releaseDate
	}
	
	static let sampleData = [
		Movie(
			title: "Deadpool and Wolverine",
			releaseDate: Date(timeIntervalSinceReferenceDate: 743_142_720)
		),
		
		Movie(
			title: "Avengers: Inifinity War",
			releaseDate: Date(timeIntervalSinceReferenceDate: 547_286_400)
		),
		
		Movie(
			title: "Aliens",
			releaseDate: Date(timeIntervalSinceReferenceDate: -455_980_800)
		)
	]
}
