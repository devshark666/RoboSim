//
//  ErrorField.swift
//  RoboSim
//
//  Created by Jesper on 21/01/2021.
//

import UIKit
import Layoutless

class ErrorField<View: UIView> {

	let reverseErrorStyle: Style<View>
	let errorStyle: Style<View>

	var showError = false {
		didSet {
			field?.apply(showError ? errorStyle : reverseErrorStyle)
		}
	}

	weak var field: View?

	init(errorStyle: Style<View>, reverseErrorStyle: Style<View>, field: View, showError: Bool = false) {
		self.errorStyle = errorStyle
		self.reverseErrorStyle = reverseErrorStyle
		self.field = field
		self.showError = showError
		
		field.apply(showError ? errorStyle : reverseErrorStyle)
	}
}

