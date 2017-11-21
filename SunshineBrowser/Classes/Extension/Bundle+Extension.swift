//
//  Bundle+Extension.swift
//  SunshineBrowser
//
//  Created by Garen on 2017/9/7.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

fileprivate class PrivateClass {
	private init() {}
}


extension Bundle {
	
	static let current = Bundle(for: PrivateClass.self)
	
	static let currentResourceBundle: Bundle? = {
		let path =  Bundle.current.path(forResource: "SunshineBrowser", ofType: "bundle") ?? ""
		let bundle = Bundle(path: path)
		return bundle
	}()
}

extension UIStoryboard {
//    static func initiate(name: String) -> UIStoryboard {
//        return UIStoryboard(name: name, bundle: Bundle.current)
//    }
}
