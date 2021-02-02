//
//  TurnCommandHandler.swift
//  RoboSim
//
//  Created by Jesper on 14/01/2021.
//

import Foundation

struct TurnCommandHandler: CommandHandler {

	let direction: RotateDirection
	
	init(direction: RotateDirection) {
		self.direction = direction
	}
	
	func execute(command: Command, on robot: RobotState) throws -> RobotState {
		return try rotate(robot: robot, direction)
	}
	
	enum RotateDirection {
		case left, right
	}
	
	private func rotate(robot: RobotState, _ direction: RotateDirection) throws -> RobotState {
		let newDirection: Direction = {
			switch robot.direction {
			case .north: return direction == .left ? .west : .east
			case .south: return direction == .left ? .east : .west
			case .east: return direction == .left ? .north : .south
			case .west: return direction == .left ? .south : .north
			}
		}()
        return try RobotState(position: robot.position, direction: newDirection, room: robot.room)
	}
}
