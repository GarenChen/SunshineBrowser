//
//  UIImage+Color.swift
//  Pods-SunshineBrowser_Example
//
//  Created by Garen on 2017/11/21.
//

import Foundation
extension UIImage {
	
	public static func from(_ color: UIColor) -> UIImage {
		
		let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
		
		UIGraphicsBeginImageContext(rect.size)
		defer { UIGraphicsEndImageContext() }
		
		let context = UIGraphicsGetCurrentContext()!
		context.setFillColor(color.cgColor)
		context.fill(rect)
		let image = UIGraphicsGetImageFromCurrentImageContext()!
		return image
	}
	
}
