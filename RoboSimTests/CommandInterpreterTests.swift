//
//  CommandInterpreterTests.swift
//  RoboSimTests
//
//  Created by Jesper on 14/01/2021.
//

import XCTest
import Combine
@testable import RoboSim

class CommandInterpreterTests: XCTestCase {
	
	let commandsInterpreter: CommandInterpreter = DefaultCommandInterpreter(commandHandlerFactory: DefaultCommandHandlerFactory())
	
	let defaultRoom = Room(width: 5, height: 5)
	
	var cancellables = Set<AnyCancellable>()
	
	func testCommandInterpreterMovement1() throws {
		
		let commandText = "RFRFFRFRF"
		let initialRobotState = try! RobotState(position: (x: 1, y: 2), direction: .north, room: defaultRoom)
		let commands = commandText.compactMap({ Command(rawValue: String($0)) })
		
		let finished = expectation(description: "all values received")
		commandsInterpreter.execute(commands: commands, on: initialRobotState).sink(receiveCompletion: { result in
			
			if case .failure(let error) = result {
				XCTFail(error.localizedDescription)
			}
			finished.fulfill()
			
		}, receiveValue: { robotState in
			
			let expectedRobotState = try! RobotState(position: (1, 3), direction: .north, room: self.defaultRoom)
			XCTAssertEqual(robotState, expectedRobotState, "Robot is in wrong state: \(robotState) expected: \(expectedRobotState)")
			
		}).store(in: &cancellables)
		
		waitForExpectations(timeout: 10, handler: nil)
	}
	
	func testCommandInterpreterMovement2() throws {
		
		let commandText = "RFLFFLRF"
		let initialRobotState = try! RobotState(position: (x: 0, y: 0), direction: .east, room: self.defaultRoom)
		let commands = commandText.compactMap({ Command(rawValue: String($0)) })
		
		let finished = expectation(description: "all values received")
		commandsInterpreter.execute(commands: commands, on: initialRobotState).sink(receiveCompletion: { result in
			
			if case .failure(let error) = result {
				XCTFail(error.localizedDescription)
			}
			finished.fulfill()
			
		}, receiveValue: { robotState in
			
			let expectedRobotState = try! RobotState(position: (x: 3, y: 1), direction: .east, room: self.defaultRoom)
			XCTAssertEqual(robotState, expectedRobotState, "Robot is in wrong state: \(robotState) expected: \(expectedRobotState)")
			
		}).store(in: &cancellables)
		
		waitForExpectations(timeout: 10, handler: nil)
	}

	func testCommandInterpreterOutOfBoundsMovement() throws {

		let commandText = "RFLFFFFFFFFLRF"
		let initialRobotState = try! RobotState(position: (x: 0, y: 0), direction: .east, room: defaultRoom)
		let commands = commandText.compactMap({ Command(rawValue: String($0)) })

		let finished = expectation(description: "all values received")
		commandsInterpreter.execute(commands: commands, on: initialRobotState).sink(receiveCompletion: { result in
			
			if case .failure(let error) = result {
				XCTAssertEqual(error, CommandError.outOfBounds)
			}
			else {
				XCTFail("Expected error")
			}
			finished.fulfill()
			
		}, receiveValue: { _ in }).store(in: &cancellables)
		
		waitForExpectations(timeout: 10, handler: nil)
	}
}
