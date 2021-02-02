//
//  RobotState.swift
//  RoboSim
//
//  Created by Jesper on 14/01/2021.
//

import Foundation

struct RobotState: Equatable {
	let position: Position
	let direction: Direction
    let room: Room
    
    init(position: Position, direction: Direction, room: Room) throws {
        self.position = position
        self.direction = direction
        self.room = room
        
        if (!room.isPositionWithinBounds(position)) {
            throw CommandError.outOfBounds
        }
    }
    
    var stateText: String {
        let orientation = "\(direction)".capitalized
        return "Position: (x: \(position.x), y: \(position.y)) \nOrientation: \(orientation)"
    }
    
	static func == (lhs: RobotState, rhs: RobotState) -> Bool {
		lhs.position == rhs.position && rhs.direction == rhs.direction
	}
}

extension RobotState: CustomDebugStringConvertible {
	var debugDescription: String {
		stateText
	}
}
