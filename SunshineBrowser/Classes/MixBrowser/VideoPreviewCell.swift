//
//  VideoPreviewCell.swift
//  SunshineBrowser
//
//  Created by ChenGuangchuan on 2017/11/19.
//  Copyright © 2017年 cgc. All rights reserved.
//

import UIKit

class VideoPreviewCell: UICollectionViewCell, PreviewContentType {
    
    var model: (URL?, UIImage?)? {
        didSet {
            guard let url = model?.0 else { return }
            self.playerItem?.removeObserver(self, forKeyPath: "status")
            self.setupPlayerItem(AVPlayerItem(url: url))
        }
    }
	
	var urlStringModel: (String?, UIImage?)? {
		didSet {
			guard let urlString = urlStringModel?.0 else { return }
			
			progressIndicator.show(in: self)
			
			BrowserConfig.shared.videoLoader.loadVideo(from: urlString, progress: nil, success: { [weak self] (url) in
				guard let `self` = self else { return }
				self.progressIndicator.dismiss()
				self.playerItem?.removeObserver(self, forKeyPath: "status")
				self.setupPlayerItem(AVPlayerItem(url: url))
			}) { [weak self] (error) in
				print("error: \(error)")
				self?.progressIndicator.dismiss()
			}
		}
	}
	
	var animationPlaceholderImage: UIImage? {
		return playerView.captureScreen()
	}
    
    var handlingView: UIView? {
        return playerView
    }
	
	lazy var progressIndicator: DefaultLoadingIndicator = {
		return DefaultLoadingIndicator.init()
	}()
    
    var tapConentToHideBar: (() -> Void)?
    
    var isPlaying: Bool = false
    
    private lazy var playerView: PlayerView = { [unowned self] in
        let playerView = PlayerView()
        self.addSubview(playerView)
        return playerView
    }()
    
    private var playerItem: AVPlayerItem?
    
    private var player: AVPlayer?
    
    private lazy var playButton: UIButton = { [unowned self] in
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage.named("icon_preview_video_play.png"), for: .normal)
        button.setImage(UIImage.named("icon_preview_video_play_highlighted.png"), for: .highlighted)
        button.addTarget(self, action: #selector(didclickPlayButton(_:)), for: .touchUpInside)
        self.addSubview(button)
        self.addConstraints([
            NSLayoutConstraint(item: button, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: button, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: button, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: button, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
            ])
        return button
        }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        _ = playerView
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        self.playerItem?.removeObserver(self, forKeyPath: "status")
    }
    
    private func setupPlayerItem(_ playerItem: AVPlayerItem) {
        self.playerItem = playerItem
        self.playerItem?.addObserver(self, forKeyPath: "status", options: .new, context: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(endPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
        player = AVPlayer(playerItem: self.playerItem)
        playerView.player = player
        playerView.frame = self.bounds
    }
    
    func recoverSubview() {
        if isPlaying {
            didclickPlayButton(playButton)
        }
    }
    
    @objc private func endPlaying() {
        didclickPlayButton(playButton)
        playerView.player.currentItem?.seek(to: CMTime(value: 0, timescale: 1))
    }
    
    @objc private func didclickPlayButton(_ sender: UIButton) {
        if !isPlaying {
            isPlaying = true
            sender.setImage(nil, for: .normal)
            sender.setImage(nil, for: .highlighted)
            play()
        } else {
            isPlaying = false
            sender.setImage(UIImage.named("icon_preview_video_play.png"), for: .normal)
            sender.setImage(UIImage.named("icon_preview_video_play_highlighted.png"), for: .highlighted)
            pause()
        }
        tapConentToHideBar?()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "status" {
            guard let item = playerItem, item.status == .readyToPlay else {
                return
            }
            _ = playButton
        }
    }
    
    private func play() {
        playerView.player.rate = 1.0
        playerView.player.play()
    }
    
    private func pause() {
        playerView.player.pause()
    }
}
