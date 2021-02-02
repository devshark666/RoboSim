//
//  RobotControlViewModel.swift
//  RoboSim
//
//  Created by Jesper on 14/01/2021.
//

import Foundation
import Combine

class MainViewModel: ObservableObject {
	
	@Published var roomWidth: Int {
		didSet {
			updateRobotState()
		}
	}
	
	@Published var roomHeight: Int {
		didSet {
			updateRobotState()
		}
	}
	
	@Published var startPositionX: Int {
		didSet {
			updateRobotState()
		}
	}
	
	@Published var startPositionY: Int {
		didSet {
			updateRobotState()
		}
	}
	
	@Published var startDirection: Direction {
		didSet {
			updateRobotState()
		}
	}
	
	@Published var commands: [Command] = []
	
	@Published var currentRobotStateText: String = ""
	
	@Published var isCommandsValid: Bool = true
	
	@Published var isUpdating: Bool = false
	
	var startDirectionText: String {
		"\(startDirection)".capitalized
	}
	
	var commandsText: String {
		commands.reduce("", { $0 + $1.rawValue })
	}
	
	var isStartPositionXValid: Bool {
		startPositionX >= 0 && startPositionX <= roomWidth
	}
	
	var isStartPositionYValid: Bool {
		startPositionY >= 0 && startPositionY <= roomHeight
	}
	
	var isCurrentRobotStateValid: Bool {
		isCommandsValid && isStartPositionXValid && isStartPositionYValid
	}
	
	private var cancellables = Set<AnyCancellable>()
	
	private var cancellableRequest: AnyCancellable?
	
	private let commandInterpreter: CommandInterpreter
	
	init(commandInterpreter: CommandInterpreter = DefaultCommandInterpreter(),
		 initialRobotState: RobotState = try! RobotState(
			position: (x: 0, y: 0),
			direction: .east,
			room: Room(width: 5, height: 5))) {
		self.commandInterpreter = commandInterpreter
		
		self.startPositionX = initialRobotState.position.x
		self.startPositionY = initialRobotState.position.y
		self.startDirection = initialRobotState.direction
		
		self.roomWidth = initialRobotState.room.width
		self.roomHeight = initialRobotState.room.height
		
		// observe changes to command array
		self.$commands.dropFirst().sink { _ in
			DispatchQueue.main.async { [weak self] in
				self?.updateRobotState()
			}
		}.store(in: &cancellables)
	}
	
	private func updateRobotStateText(with result: Result<RobotState, Error>) {
		switch result {
		case .success(let robotState):
			self.isCommandsValid = true
			self.currentRobotStateText = robotState.stateText
		case .failure(let error):
			self.isCommandsValid = false
			
			switch error {
			case CommandError.outOfBounds:
				self.currentRobotStateText = "Out of bounds!"
			default:
				self.currentRobotStateText = error.localizedDescription
			}
		}
	}
	
	private func getInitialRobotState() throws -> RobotState {
		try RobotState(
			position: (x: self.startPositionX, y: self.startPositionY),
			direction: self.startDirection,
			room: Room(width: self.roomWidth, height: self.roomHeight))
	}
	
	private func updateRobotState() {
		// cancel any ongoing robot state request
		if (cancellableRequest != nil) {
			cancellableRequest?.cancel()
			cancellableRequest = nil
		}
		
		// perform new robot state request
		do {
			let robot = try self.getInitialRobotState()
			isUpdating = true
			self.cancellableRequest = commandInterpreter.execute(commands: self.commands, on: robot)
				.receive(on: DispatchQueue.main)
				.sink(receiveCompletion: { [weak self] result in
					self?.cancellableRequest = nil
					self?.isUpdating = false

					if case .failure(let error) = result {
						self?.updateRobotStateText(with: .failure(error))
					}
				}, receiveValue: { [weak self] state in
					self?.updateRobotStateText(with: .success(state))
				})
		}
		catch let error {
			updateRobotStateText(with: .failure(error))
		}
	}
	
	func clearCommands() {
		commands.removeAll()
	}
	
	func addCommand(_ command: Command) {
		commands.append(command)
	}
}
