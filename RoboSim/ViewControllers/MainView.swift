//
//  MainView.swift
//  RoboSim
//
//  Created by Jesper on 19/01/2021.
//

import UIKit
import Layoutless

class MainView: UI.View {

	let titleLabel = UI.Label(styles: [Stylesheet.title, .text("RoboSim")])
	
	let roomSizeView = RoomSizeView()

	let startPositionView = StartPositionView()
	
	let robotControlView = RobotControlView()
	
	let robotStateView = RobotStateView()

	override var subviewsLayout: AnyLayout {
		stack(.vertical, spacing: 24, configure: { stackView in
			stackView.isLayoutMarginsRelativeArrangement = true
			stackView.layoutMargins = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
		}) (
			UIView(),
			titleLabel,
			roomSizeView,
			startPositionView,
			robotControlView,
			robotStateView
		)
		.scrolling(.vertical)
		.fillingParent(relativeToSafeArea: false)
	}
}
