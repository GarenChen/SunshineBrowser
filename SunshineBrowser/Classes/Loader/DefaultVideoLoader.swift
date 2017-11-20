//
//  DefaultVideoLoader.swift
//  Pods-SunshineBrowser_Example
//
//  Created by Garen on 2017/11/20.
//

import Foundation

class DefaultVideoLoader: NSObject, VideoDownloadType, URLSessionDownloadDelegate {
	
	private weak var task: URLSessionDownloadTask?
	
	private var progress: ((Int, Int, Float) -> Void)?
	
	private var success: ((URL) -> Void)?
	
	private var failure: ((Error?) -> Void)?
	
	override init() {
		super.init()
	}
	
	deinit {
		task?.cancel()
	}
	
	lazy var session: URLSession = { [unowned self] in
		return URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())
	}()

	func loadVideo(from urlString: String?, progress: ((Int, Int, Float) -> Void)?, success: @escaping ((URL) -> Void), failure: ((Error?) -> Void)?) {
		
		guard let url = URL(string: urlString ?? "") else {
			print("urlString 错误")
			return
		}
		
		self.success = success
		self.progress = progress
		self.failure = failure
		
		task = session.downloadTask(with: url)
		task?.resume()
	}

	func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
		success?(location)
	}
	
	func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
		failure?(error)
	}
	
	
	func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
		progress?(Int(totalBytesWritten), Int(totalBytesExpectedToWrite), Float(totalBytesWritten) / Float(totalBytesExpectedToWrite))
	}
	
}
