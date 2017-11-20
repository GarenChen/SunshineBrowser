//
//  BrowserConfig.swift
//  Pods-SunshineBrowser_Example
//
//  Created by Garen on 2017/11/20.
//

import Foundation

public class BrowserConfig {
	
	static let shared = BrowserConfig()
	
	public var imageLoader: ImageDownloadType
	public var videoLoader: VideoDownloadType
	public var imageProgressIndicator: ProgressIndicatorType
	public var videoProgressIndicator: ProgressIndicatorType
	
	public convenience init() {
		self.init(imageLoader: DefaultImageDownloader(), videoLoader: DefaultVideoLoader(), imageProgressIndicator: DefaultLoadingIndicator(), videoProgressIndicator: DefaultLoadingIndicator())
	}
	
	public init(imageLoader: ImageDownloadType,
	     videoLoader: VideoDownloadType,
	     imageProgressIndicator: ProgressIndicatorType,
	     videoProgressIndicator: ProgressIndicatorType) {
		self.imageLoader = imageLoader
		self.videoLoader = videoLoader
		self.imageProgressIndicator = imageProgressIndicator
		self.videoProgressIndicator = videoProgressIndicator
	}

}
