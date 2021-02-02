//
//  StartPositionView.swift
//  RoboSim
//
//  Created by Jesper on 20/01/2021.
//

import UIKit
import Layoutless

class StartPositionView: UI.View {

	let container = UI.View(style: Stylesheet.Group.container)
	
	let titleLabel = UI.Label(style: Stylesheet.Group.title)
	
	let xPositionLabel = UI.Label(style: Stylesheet.Field.title)
	
	let xPositionField = NumericField(style: Stylesheet.Field.value)
	
	let yPositionLabel = UI.Label(style: Stylesheet.Field.title)
	
	let yPositionField = NumericField(style: Stylesheet.Field.value)
	
	let directionLabel = UI.Label(style: Stylesheet.Field.title)
	
	let directionButton = UI.Button(style: Stylesheet.Command.button)
	
	func setDirectionText(_ text: String) {
		directionButton.setTitle(text, for: .normal)
	}
	
	override var subviewsLayout: AnyLayout {
		
		return stack(.vertical, spacing: 16) (
			titleLabel,
			
			stack(.horizontal, spacing: 8, distribution: .fillEqually, alignment: .fill) (
				stack(.vertical, spacing: 4) (
					stack(.horizontal, spacing: 8, distribution: .fillEqually) (
						xPositionLabel,
						yPositionLabel,
						directionLabel
					),
					
					stack(.horizontal, spacing: 8, distribution: .fillEqually) (
						xPositionField,
						yPositionField,
						directionButton
					)
				)
			)
		)
		.fillingParentMargin()
		.embedding(in: container)
		.fillingParent()
	}
	
	override func setup() {
		titleLabel.text = "Start Position"
		xPositionLabel.text = "X Position"
		yPositionLabel.text = "Y Position"
		directionLabel.text = "Direction"
	}
}
