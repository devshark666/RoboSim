//
//  ContentViewController.swift
//  RoboSim
//
//  Created by Jesper on 19/01/2021.
//

import UIKit
import Layoutless

class ContentViewController<TheView: UIView>: UI.ViewController {
	
	var contentView: TheView {
		return self.view as! TheView
	}
	
	init() {
		super.init(nibName: nil, bundle: nil)
	}
	
	@available(*, unavailable) required public init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func loadView() {
		super.loadView()
		view = TheView()
	}
}
