//
//  MainViewController.swift
//  RoboSim
//
//  Created by Jesper on 14/01/2021.
//

import UIKit
import Combine
import SwiftUI

class MainViewController: ContentViewController<MainView> {
	
	var viewModel = MainViewModel()
	
	var cancellable: AnyCancellable?
	
	lazy var xPositionField = BorderErrorField(field: self.contentView.startPositionView.xPositionField)
	
	lazy var yPositionField = BorderErrorField(field: self.contentView.startPositionView.yPositionField)
	
	lazy var commandsField = BorderErrorField(field: self.contentView.robotControlView.commandsField)
	
	lazy var stateField = BorderErrorField(field: self.contentView.robotStateView.stateField)
	
	override func setup() {
		self.view.backgroundColor = UIColor.white
		
		self.contentView.roomSizeView.widthField.numberChanged = { [weak self] number in
			self?.viewModel.roomWidth = number
		}
		self.contentView.roomSizeView.heightField.numberChanged = { [weak self] number in
			self?.viewModel.roomHeight = number
		}
		
		self.contentView.startPositionView.xPositionField.numberChanged = { [weak self] number in
			self?.viewModel.startPositionX = number
		}
		self.contentView.startPositionView.yPositionField.numberChanged = { [weak self] number in
			self?.viewModel.startPositionY = number
		}
		self.contentView.startPositionView.directionButton.addTarget(self, action: #selector(changeStartDirection), for: .touchUpInside)
		
		self.contentView.robotControlView.commandsField.text = self.viewModel.commandsText
		self.contentView.robotControlView.leftButton.addTarget(self, action: #selector(left), for: .touchUpInside)
		self.contentView.robotControlView.rightButton.addTarget(self, action: #selector(right), for: .touchUpInside)
		self.contentView.robotControlView.forwardButton.addTarget(self, action: #selector(forward), for: .touchUpInside)
		self.contentView.robotControlView.clearCommands = {
			self.viewModel.clearCommands()
		}
		
		cancellable = viewModel.objectWillChange
			.sink { _ in
				DispatchQueue.main.async { [weak self] in
					self?.syncWithModel()
				}
		}
		
		syncWithModel()
	}
	
	@objc
	func changeStartDirection() {
		UIAlertController.create(message: "Select Direction", style: .actionSheet)
			.addAction(title: "North", action: { self.viewModel.startDirection = .north })
			.addAction(title: "East", action: { self.viewModel.startDirection = .east })
			.addAction(title: "South", action: { self.viewModel.startDirection = .south })
			.addAction(title: "West", action: { self.viewModel.startDirection = .west })
			.addAction(title: "Cancel", style: .cancel)
			.present(on: self)
	}
	
	@objc
	func left() {
		self.viewModel.addCommand(.left)
	}
	
	@objc
	func right() {
		self.viewModel.addCommand(.right)
	}
	
	@objc
	func forward() {
		self.viewModel.addCommand(.forward)
	}
	
	func syncWithModel() {
		contentView.roomSizeView.widthField.number = self.viewModel.roomWidth
		contentView.roomSizeView.heightField.number = self.viewModel.roomHeight
		
		xPositionField.field?.number = self.viewModel.startPositionX
		yPositionField.field?.number = self.viewModel.startPositionY
		contentView.startPositionView.setDirectionText(self.viewModel.startDirectionText)
		
		commandsField.field?.text = self.viewModel.commandsText
		
		stateField.field?.text = self.viewModel.currentRobotStateText
		
		xPositionField.showError = !self.viewModel.isStartPositionXValid
		yPositionField.showError = !self.viewModel.isStartPositionYValid

		commandsField.showError = !self.viewModel.isCommandsValid
		stateField.showError = !self.viewModel.isCurrentRobotStateValid
		
		contentView.robotStateView.activityView.isActive = self.viewModel.isUpdating
	}
}
