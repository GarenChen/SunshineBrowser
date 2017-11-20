//
//   ProgressIndicatorType.swift
//  Pods-SunshineBrowser_Example
//
//  Created by Garen on 2017/11/20.
//

import Foundation
/// 图片加载协议
public protocol ProgressIndicatorType: class {
	func show(in view: UIView)
	func dismiss()
	func updateProgress(current: Int?, total: Int?, percent: Float?)
}

