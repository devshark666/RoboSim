//
//  UIActivityIndicatorView+IsActive.swift
//  RoboSim
//
//  Created by Jesper on 02/02/2021.
//

import Foundation
import UIKit

extension UIActivityIndicatorView {
	
	var isActive: Bool {
		get {
			return self.isAnimating
		}
		set {
			if newValue {
				self.startAnimating()
			}
			else {
				self.stopAnimating()
			}
		}
	}
}
