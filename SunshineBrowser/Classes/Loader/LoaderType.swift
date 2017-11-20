//
//  LoaderType.swift
//  Pods-SunshineBrowser_Example
//
//  Created by Garen on 2017/11/20.
//

import Foundation
/// 图片加载协议
public protocol ImageDownloadType {
	func loadImage(from urlString: String?, progress: ((Int, Int, Float) -> Void)?, success:@escaping ((UIImage) -> Void), failure: ((Error?) -> Void)?)
}

/// 视频加载协议
public protocol VideoDownloadType {
	func loadVideo(from urlString: String?, progress: ((Int, Int, Float) -> Void)?, success:@escaping ((URL) -> Void), failure: ((Error?) -> Void)?)
}



