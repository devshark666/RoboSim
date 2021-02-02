//
//  UIFont.swift
//  RoboSim
//
//  Created by Jesper on 19/01/2021.
//

import UIKit

extension UIFont {
	
	static func header(weight: UIFont.Weight = .regular) -> UIFont {
		UIFont.monospacedSystemFont(ofSize: 42, weight: weight)
	}

	static func subheader(weight: UIFont.Weight = .regular) -> UIFont {
		UIFont.monospacedSystemFont(ofSize: 22, weight: weight)
	}
	
	static func body(weight: UIFont.Weight = .regular) -> UIFont {
		UIFont.monospacedSystemFont(ofSize: 12, weight: weight)
	}
	
	static var body: UIFont {
		get { .body() }
	}
	
	static var header: UIFont {
		get { .header(weight: .bold) }
	}
	
	static var subheader: UIFont {
		get { .subheader(weight: .medium) }
	}
}
