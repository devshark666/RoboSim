//
//  CommandInterpreter.swift
//  RoboSim
//
//  Created by Jesper on 14/01/2021.
//

import Foundation
import Combine

/// A class that can execute a series of commands should implement this protocol
protocol CommandInterpreter {
	func execute(commands: [Command], on robot: RobotState) -> AnyPublisher<RobotState, CommandError>
}
