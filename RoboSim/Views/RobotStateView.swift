//
//  RobotStateView.swift
//  RoboSim
//
//  Created by Jesper on 20/01/2021.
//

import UIKit
import Layoutless

class RobotStateView: UI.View {

	let container = UI.View(style: Stylesheet.Group.container)
	
	let titleLabel = UI.Label(style: Stylesheet.Group.title)
	
	let stateField = UI.TextField(
		styles: [
			.textAlignment(.center),
			.autocorrectionType(.no),
			.autocapitalizationType(.none),
			.disableUserInteraction(),
			.border(color: .lightGray),
			.roundedCorners(),
			.textInsets(UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0))
		])
	
	let activityView = UIActivityIndicatorView()
	
	override var subviewsLayout: AnyLayout {
		
		activityView.centeringInParent().layout(in: container)
		
		return stack(.vertical, spacing: 16) (
			titleLabel,
			
			stateField
		)
		.fillingParentMargin()
		.embedding(in: container)
		.fillingParent()
	}
	
	override func setup() {
		titleLabel.text = "Robot State"
	}
}
