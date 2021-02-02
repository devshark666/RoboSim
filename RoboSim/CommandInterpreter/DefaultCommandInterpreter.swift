//
//  DefaultCommandInterpreter.swift
//  RoboSim
//
//  Created by Jesper on 14/01/2021.
//

import Foundation
import Combine

protocol CommandHandlerFactory {
	func create(from command: Command) -> CommandHandler
}

class DefaultCommandHandlerFactory: CommandHandlerFactory {
	func create(from command: Command) -> CommandHandler {
		switch command {
		case .forward: return ForwardCommandHandler()
		case .left: return TurnCommandHandler(direction: .left)
		case .right: return TurnCommandHandler(direction: .right)
		}
	}
}

struct DefaultCommandInterpreter: CommandInterpreter {
	
	let commandHandlerFactory: CommandHandlerFactory
	
	init(commandHandlerFactory: CommandHandlerFactory = DefaultCommandHandlerFactory()) {
		self.commandHandlerFactory = commandHandlerFactory
	}
	
	func execute(commands: [Command], on robot: RobotState) -> AnyPublisher<RobotState, CommandError> {
		commands.publisher.setFailureType(to: CommandError.self)
			.subscribe(on: DispatchQueue.global(qos: .background))
			.tryReduce(robot) { newState, command -> RobotState in
				// simulate delay
				Thread.sleep(forTimeInterval: 0.5)
				
				let handler = self.commandHandlerFactory.create(from: command)
				return try handler.execute(command: command, on: newState)
			}.mapError({ (error) -> CommandError in
				return CommandError.outOfBounds
			}).eraseToAnyPublisher()
	}
}
