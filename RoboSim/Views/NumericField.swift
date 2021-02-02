//
//  NumericField.swift
//  RoboSim
//
//  Created by Jesper on 20/01/2021.
//

import UIKit
import Layoutless

class NumericField: UI.TextField {
	
	var numberChanged: ((_ number: Int) -> Void)?
	
	private var numberFormatter: NumberFormatter {
		let formatter = NumberFormatter()
		formatter.numberStyle = .none
		return formatter
	}
	
	var number: Int {
		get {
			Int(truncating: numberFormatter.number(from: self.text ?? "") ?? 0)
		}
		set {
			super.text = numberFormatter.string(from: NSNumber(value: newValue))
		}
	}
	
	private let inset: CGFloat = 4
	
	override func setup() {
		self.font = .systemFont(ofSize: 12)
		self.textColor = .black
		self.keyboardType = .numberPad
		self.backgroundColor = .white
		self.tintColor = .black

		self.textInsets = UIEdgeInsets(top: self.inset, left: self.inset, bottom: self.inset, right: self.inset)
		
		self.addTarget(self, action: #selector(textEdited(sender:)), for: .editingChanged)
	}

	private func setFormattedText(_ text: String?) {
		guard let string = text, let integer = Int(string) else {
			super.text = text
			return
		}
		self.number = integer
	}
	
	@objc
	func textEdited(sender: UITextField) {
		setFormattedText(sender.text)

		numberChanged?(number)
	}
}
