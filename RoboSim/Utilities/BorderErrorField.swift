//
//  BorderErrorField.swift
//  RoboSim
//
//  Created by Jesper on 21/01/2021.
//

import UIKit
import Layoutless

class BorderErrorField<View: UIView> : ErrorField<View> {
	
	init(field: View, normalBorderColor: UIColor = .lightGray, errorBorderColor: UIColor = .systemRed) {
		super.init(
			errorStyle: Style<View>.border(color: errorBorderColor),
			reverseErrorStyle: Style<View>.border(color: normalBorderColor),
			field: field,
			showError: false)
	}
}
