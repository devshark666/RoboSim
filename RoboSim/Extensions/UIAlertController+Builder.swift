//
//  UIAlertController+Builder.swift
//  RoboSim
//
//  Created by Jesper on 20/01/2021.
//

import UIKit

extension UIAlertController {
	
	private class MyAlertController: UIAlertController {
		var completion: (() -> Void)? = nil
	}
	
	static func create(title: String? = nil, message: String?, style: Style) -> UIAlertController {
		MyAlertController(title: title, message: message, preferredStyle: style)
	}
	
	func addAction(title: String, style: UIAlertAction.Style = .default, action: (() -> Void)? = nil) -> UIAlertController {
		let alertAction = UIAlertAction(title: title, style: style) { _ in
			action?()
			(self as? MyAlertController)?.completion?()
		}
		self.addAction(alertAction)

		return self
	}
	
	func addCompletionHandler(_ handler: @escaping () -> Void) -> UIAlertController {
		(self as? MyAlertController)?.completion = handler
		
		return self
	}
	
	func present(on viewController: UIViewController) {
		viewController.present(self, animated: true, completion: nil)
	}
}
