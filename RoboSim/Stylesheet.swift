//
//  Stylesheet.swift
//  RoboSim
//
//  Created by Jesper on 20/01/2021.
//

import UIKit
import Layoutless

class Stylesheet {
	
	static var title: Style<UILabel> {
		return Style(styles: [
			.font(.header),
			.textAlignment(.center)
		])
	}
	
	enum Field {
		
		static var title: Style<UILabel> {
			Style(styles: [
				.font(.body),
				.textAlignment(.center)
			])
		}
		
		static var value: Style<NumericField> {
			return Style(styles: [
				.font(.body),
				.textAlignment(.center),
				.textColor(.black),
				.backgroundColor(.white),
				.tintColor(.black),
				.border(color: .lightGray),
				.roundedCorners()
			])
		}
		
	}
	
	enum Group {
		
		static var container: Style<UIView> {
			Style(styles: [
				.backgroundColor(.white),
				.border(color: .lightGray),
				.roundedCorners(),
				.shadow()
			])
		}
		
		static var title: Style<UILabel> {
			Style(styles: [
				.font(.subheader),
				.textColor(.blue),
				.textAlignment(.center)
			])
		}
		
	}
	
	enum Command {
		
		static var button: Style<UIButton> {
			Style(styles: [
				.titleFont(.body),
				.titleColor(.black),
				.titleColor(.lightGray, for: .highlighted),
				.imageEdgeInsets(UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 0)),
				.contentEdgeInsets(UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0)),
				.backgroundColor(.clear),
				.border(color: .lightGray),
				.roundedCorners()
			])
		}
		
		static var commands: Style<UITextField> {
			return Style(styles: [
				.font(.body),
				.textAlignment(.center),
				.border(color: .lightGray),
				.roundedCorners(),
				.backgroundColor(.white),
				.tintColor(.black),
				.textColor(.black)
			])
		}
	}
}
