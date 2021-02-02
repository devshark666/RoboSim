//
//  RoomSizeView.swift
//  RoboSim
//
//  Created by Jesper on 19/01/2021.
//

import UIKit
import Layoutless

class RoomSizeView: UI.View {

	let container = UI.View(style: Stylesheet.Group.container)
	
	let titleLabel = UI.Label(style: Stylesheet.Group.title)
	
	let widthLabel = UI.Label(style: Stylesheet.Field.title)
	
	let widthField = NumericField(style: Stylesheet.Field.value)
	
	let heightLabel = UI.Label(style: Stylesheet.Field.title)
	
	let heightField = NumericField(style: Stylesheet.Field.value)
	
	override var subviewsLayout: AnyLayout {
		
		return stack(.vertical, spacing: 16) (
			titleLabel,
			
			stack(.horizontal, spacing: 8, distribution: .fillEqually, alignment: .fill) (
				stack(.vertical, spacing: 4) (
					stack(.horizontal, spacing: 8, distribution: .fillEqually) (
						widthLabel,
						heightLabel
					),
					
					stack(.horizontal, spacing: 8, distribution: .fillEqually) (
						widthField,
						heightField
					)
				)
			)
		)
		.fillingParentMargin()
		.embedding(in: container)
		.fillingParent()
	}
	
	override func setup() {
		titleLabel.text = "Room Size"
		widthLabel.text = "Width"
		heightLabel.text = "Height"
	}
}
