//
//  PhotoPreviewCell.swift
//  SunshineBrowser
//
//  Created by ChenGuangchuan on 2017/11/19.
//  Copyright © 2017年 cgc. All rights reserved.
//

import UIKit

class PhotoPreviewCell: UICollectionViewCell, UIScrollViewDelegate, PreviewContentType {
    
    @IBOutlet private weak var contentScrollView: UIScrollView!
    
    @IBOutlet private weak var contentImageView: UIImageView!
	
	var animationPlaceholderImage: UIImage? {
		return contentImageView.image
	}
    
    var handlingView: UIView? {
        return contentImageView
    }
    
    var tapConentToHideBar: (() -> Void)?
    
    var image: UIImage? {
        didSet {
            self.contentImageView.image = image ?? UIImage.named("placeholderImage.png")
        }
    }
	
	lazy var progressIndicator: DefaultLoadingIndicator = {
		return DefaultLoadingIndicator.init()
	}()
	
	var model: (String?, UIImage?)? {
		didSet {
			guard let urlString = model?.0 else { return }
			
			progressIndicator.show(in: self)
			
			self.contentImageView.image = model?.1 ?? UIImage.named("placeholderImage.png")
			BrowserConfig.shared.imageLoader.loadImage(from: urlString, progress: nil, success: { [weak self] (image) in
				self?.progressIndicator.dismiss()
				self?.contentImageView.image = image
			}) { [weak self] (error) in
				print("error: \(error)")
				self?.progressIndicator.dismiss()
				self?.contentImageView.image = UIImage.named("placeholderImage.png")
			}
		}
	}
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentScrollView.delegate = self
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(singleTapImageView))
        addGestureRecognizer(singleTap)
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTapImageView(_:)))
        doubleTap.numberOfTapsRequired = 2
        addGestureRecognizer(doubleTap)
        singleTap.require(toFail: doubleTap)
    }
    
    func recoverSubview() {
        contentScrollView.setZoomScale(1, animated: false)
    }
    
    @objc func singleTapImageView() {
        tapConentToHideBar?()
    }
    
    @objc func doubleTapImageView(_ gesture: UITapGestureRecognizer) {
        if contentScrollView.zoomScale > 1 {
            contentScrollView.setZoomScale(1, animated: true)
        } else {
            let touchPoint = gesture.location(in: contentImageView)
            let newScale = contentScrollView.maximumZoomScale
            let xSize = frame.size.width / newScale
            let ySize = frame.size.height / newScale
            contentScrollView.zoom(to: CGRect(x: touchPoint.x - xSize/2, y: touchPoint.y - ySize/2, width: xSize, height: ySize), animated: true)
        }
    }
    
    // MARK: - UIScroll view delegate
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return contentImageView
    }
    
}
