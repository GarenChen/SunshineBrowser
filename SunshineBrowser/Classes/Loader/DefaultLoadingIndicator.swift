//
//  DefaultLoadingIndicator.swift
//  Pods-SunshineBrowser_Example
//
//  Created by Garen on 2017/11/20.
//

import Foundation

class DefaultLoadingIndicator: UIActivityIndicatorView, ProgressIndicatorType {
	
	convenience init() {
		self.init(frame: .zero)
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.hidesWhenStopped = true
		self.activityIndicatorViewStyle = .gray
	}
	
	required init(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func show(in view: UIView) {
		self.frame = view.bounds
		self.startAnimating()
	}
	
	func dismiss() {
		self.stopAnimating()
		self.removeFromSuperview()
	}
	
	func updateProgress(current: Int?, total: Int?, percent: Float?) {
		self.startAnimating()
	}
	
}
