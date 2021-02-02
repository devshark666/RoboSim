//
//  MainViewModelTests.swift
//  RoboSimTests
//
//  Created by Jesper on 14/01/2021.
//

import XCTest
import Combine
@testable import RoboSim

class MainViewModelTests: XCTestCase {

	let defaultRoom = Room(width: 5, height: 5)

	var cancellables = Set<AnyCancellable>()
	
	func testInit() throws {
		let robotState = try! RobotState(position: (x: 3, y: 4), direction: .north, room: defaultRoom)

		let viewModel = MainViewModel(initialRobotState: robotState)
		
		XCTAssertEqual(viewModel.startPositionX, robotState.position.x)
		XCTAssertEqual(viewModel.startPositionY, robotState.position.y)
		XCTAssertEqual(viewModel.startDirection, robotState.direction)
		XCTAssertEqual(viewModel.roomWidth, robotState.room.width)
		XCTAssertEqual(viewModel.roomHeight, robotState.room.height)
	}
	
	func testValidInput() {
		let robotState = try! RobotState(position: (x: 3, y: 4), direction: .north, room: defaultRoom)

		let viewModel = MainViewModel(initialRobotState: robotState)
		
		XCTAssertTrue(viewModel.isCommandsValid)
		XCTAssertTrue(viewModel.isStartPositionYValid)
		XCTAssertTrue(viewModel.isStartPositionXValid)
		XCTAssertTrue(viewModel.isCurrentRobotStateValid)
	}
	
	func testInvalidStartPositionX() {
		let robotState = try! RobotState(position: (x: 0, y: 0), direction: .north, room: defaultRoom)
		
		let viewModel = MainViewModel(initialRobotState: robotState)
		
		viewModel.startPositionX = 13
		
		XCTAssertTrue(viewModel.isStartPositionYValid)
		XCTAssertFalse(viewModel.isStartPositionXValid)
		XCTAssertFalse(viewModel.isCurrentRobotStateValid)
	}
	
	func testInvalidStartPositionY() {
		let robotState = try! RobotState(position: (x: 0, y: 0), direction: .north, room: defaultRoom)
		
		let viewModel = MainViewModel(initialRobotState: robotState)
		
		viewModel.startPositionY = 13
		
		XCTAssertFalse(viewModel.isStartPositionYValid)
		XCTAssertTrue(viewModel.isStartPositionXValid)
		XCTAssertFalse(viewModel.isCurrentRobotStateValid)
	}
	
	func testValidCommands() {
		let robotState = try! RobotState(position: (x: 0, y: 0), direction: .east, room: defaultRoom)
		
		let viewModel = MainViewModel(initialRobotState: robotState)
		
		let finished = expectation(description: "all values received")
		viewModel.$currentRobotStateText.dropFirst().sink { _ in
			
			XCTAssertTrue(viewModel.isStartPositionXValid)
			XCTAssertTrue(viewModel.isStartPositionYValid)
			XCTAssertTrue(viewModel.isCommandsValid)
			XCTAssertTrue(viewModel.isCurrentRobotStateValid)
			
			finished.fulfill()
		}.store(in: &cancellables)
		
		viewModel.addCommand(.forward)
		
		waitForExpectations(timeout: 10, handler: nil)
	}
	
	func testInvalidCommands() {
		let robotState = try! RobotState(position: (x: 0, y: 0), direction: .north, room: defaultRoom)
		
		let viewModel = MainViewModel(initialRobotState: robotState)
		
		let finished = expectation(description: "all values received")
		viewModel.$currentRobotStateText.dropFirst().sink { _ in
			
			XCTAssertTrue(viewModel.isStartPositionXValid)
			XCTAssertTrue(viewModel.isStartPositionYValid)
			XCTAssertFalse(viewModel.isCommandsValid)
			XCTAssertFalse(viewModel.isCurrentRobotStateValid)
			
			finished.fulfill()
		}.store(in: &cancellables)
		
		viewModel.addCommand(.forward)

		waitForExpectations(timeout: 10, handler: nil)
	}
	
	func testAppendCommandText() {
		let robotState = try! RobotState(position: (x: 0, y: 0), direction: .north, room: defaultRoom)
		
		let viewModel = MainViewModel(initialRobotState: robotState)
		
		XCTAssertTrue(viewModel.commandsText.isEmpty)
		
		viewModel.addCommand(.forward)
		
		XCTAssertFalse(viewModel.commandsText.isEmpty)
	}
	
	func testClearCommandText() {
		let robotState = try! RobotState(position: (x: 0, y: 0), direction: .north, room: defaultRoom)
		
		let viewModel = MainViewModel(initialRobotState: robotState)
		
		viewModel.addCommand(.forward)
		
		XCTAssertFalse(viewModel.commandsText.isEmpty)
		
		viewModel.clearCommands()
		
		XCTAssertTrue(viewModel.commandsText.isEmpty)
	}
}
