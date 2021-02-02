//
//  ForwardCommandHandler.swift
//  RoboSim
//
//  Created by Jesper on 14/01/2021.
//

import Foundation

struct ForwardCommandHandler: CommandHandler {
	
	func execute(command: Command, on robot: RobotState) throws -> RobotState {
		try moveForward(robot: robot)
	}
	
	private func moveForward(robot: RobotState) throws -> RobotState {
		let position = robot.position
		let newPosition: Position = {
			switch robot.direction {
			case .north: return (position.x, position.y - 1)
			case .south: return (position.x, position.y + 1)
			case .east: return (position.x + 1, position.y)
			case .west: return (position.x - 1, position.y)
			}
		}()
        return try RobotState(position: newPosition, direction: robot.direction, room: robot.room)
	}
}
