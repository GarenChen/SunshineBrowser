//
//  UIImage+Current.swift
//  Pods-SunshineBrowser_Example
//
//  Created by Garen on 2017/11/20.
//

import Foundation

extension UIImage {
	static func named(_ name: String) -> UIImage? {
		return UIImage(named: name, in: Bundle.currentResourceBundle, compatibleWith: nil)
	}
}
