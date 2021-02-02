//
//  RobotControlView.swift
//  RoboSim
//
//  Created by Jesper on 20/01/2021.
//

import UIKit
import Layoutless

class RobotControlView: UI.View {

	let container = UI.View(style: Stylesheet.Group.container)
	
	let titleLabel = UI.Label(style: Stylesheet.Group.title)
	
	let commandsField = UI.TextField(
		styles: [
			.textAlignment(.center),
			.autocorrectionType(.no),
			.autocapitalizationType(.none),
			.clearButtonMode(.always),
			.border(color: .lightGray),
			.roundedCorners(),
			.textInsets(UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0))
		])
	
	let leftButton = UI.Button(
		style: Stylesheet.Command.button.adding(.title("Left"))
			.add(.image(UIImage(systemName: "chevron.left.circle.fill"))))
	
	let rightButton = UI.Button(
		style: Stylesheet.Command.button.adding(.title("Right"))
			.add(.image(UIImage(systemName: "chevron.right.circle.fill"))))
	
	let forwardButton = UI.Button(
		style: Stylesheet.Command.button.adding(.title("Forward"))
			.add(.image(UIImage(systemName: "chevron.up.circle.fill"))))
	
	var clearCommands: (() -> Void)?
	
	override var subviewsLayout: AnyLayout {
		
		return stack(.vertical, spacing: 16) (
			titleLabel,
			
			commandsField,
			
			stack(.horizontal, spacing: 10, distribution: .fillEqually, alignment: .fill) (
				leftButton,
				
				forwardButton,
				
				rightButton
			)
		)
		.fillingParentMargin()
		.embedding(in: container)
		.fillingParent()
	}
	
	override func setup() {
		titleLabel.text = "Robot Control"

		commandsField.delegate = self
	}
}

/// Disable editing but enable clear button
extension RobotControlView: UITextFieldDelegate {
	
	func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
		return false
	}
	
	func textFieldShouldClear(_ textField: UITextField) -> Bool {
		clearCommands?()
		
		return true
	}
}

