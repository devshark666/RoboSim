//
//  CommandHandler.swift
//  RoboSim
//
//  Created by Jesper on 14/01/2021.
//

import Foundation

/// Classes which can handle one or more commands should implement this protocol
protocol CommandHandler {
	func execute(command: Command, on robot: RobotState) throws -> RobotState
}
