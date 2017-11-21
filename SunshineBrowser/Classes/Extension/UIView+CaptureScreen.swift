//
//  UIView+CaptureScreen.swift
//  Pods-SunshineBrowser_Example
//
//  Created by Garen on 2017/11/21.
//

import Foundation

extension UIView {
	
	func captureScreen(canSaveToAlbum: Bool = true) -> UIImage? {
		
		UIGraphicsBeginImageContext(self.bounds.size)
		
		guard let context = UIGraphicsGetCurrentContext() else {
			return nil
		}
		
		layer.render(in: context)
		
		guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
			return nil
		}
		
		UIGraphicsEndImageContext()
		
		if canSaveToAlbum {
			UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
		}
		return image
	}
	
//	func captureScreen(canSaveToAlbum: Bool = true, finished: ((UIImage?) -> Void)?) {
//
//		UIGraphicsBeginImageContext(self.bounds.size)
//
//		guard let context = UIGraphicsGetCurrentContext() else {
//			finished?(nil)
//			return
//		}
//
//		layer.render(in: context)
//
//		guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
//			finished?(nil)
//			return
//		}
//
//		UIGraphicsEndImageContext()
//
//		if canSaveToAlbum {
//			UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
//		}
//		finished?(image)
//	}
}
