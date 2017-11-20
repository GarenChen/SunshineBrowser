//
//  DefaultImageLoader.swift
//  Pods-SunshineBrowser_Example
//
//  Created by Garen on 2017/11/20.
//

import Foundation

class DefaultImageDownloader: ImageDownloadType {
	
	func loadImage(from urlString: String?, progress: ((Int, Int, Float) -> Void)? = nil, success: @escaping ((UIImage) -> Void), failure: ((Error?) -> Void)? = nil) {
		
		guard let url = URL(string: urlString ?? "") else {
			failure?(NSError(domain: "create URL from urlString fail", code: 9999, userInfo: nil))
			return
		}
		
		DispatchQueue.global().async {
			do {
				let data = try Data(contentsOf: url)
				guard let image = UIImage(data: data) else {
					failure?(NSError(domain: "download image is nil", code: 9999, userInfo: nil))
					return
				}
				DispatchQueue.main.async {
					success(image)
				}
			} catch let exception {
				failure?(NSError(domain: "download image fail", code: 9999, userInfo: nil))
				debugPrint(exception)
			}
		}
		
	}
}
