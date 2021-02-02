//
//  Room.swift
//  RoboSim
//
//  Created by Jesper on 14/01/2021.
//

import Foundation

struct Room {
	let width: Int
	let height: Int
	
	func isPositionWithinBounds(_ position: Position) -> Bool {
		return position.x >= 0 && position.x <= width &&
			position.y >= 0 && position.y <= height
	}
}
