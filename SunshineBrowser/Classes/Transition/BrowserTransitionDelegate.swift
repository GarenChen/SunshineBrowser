//
//  BrowserTransitionDelegate.swift
//  SunshineBrowser
//
//  Created by Garen on 2017/11/13.
//  Copyright © 2017年 cgc. All rights reserved.
//

import UIKit

class BrowserTransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {

    private var originFrame: CGRect?
    
    private var destinationFrame: CGRect?
    
    private var placeholderImage: UIImage?
	
	private override init() {
		super.init()
	}

    convenience init(placeholderImage: UIImage?, originFrame: CGRect?, destinationFrame: CGRect?) {
        self.init()
        self.originFrame = originFrame
        self.destinationFrame = destinationFrame
        self.placeholderImage = placeholderImage
    }
    
    func changePlaceholder(_ placeholderImage: UIImage?) {
        self.placeholderImage = placeholderImage
    }
    
    func changeDestinationFrame(_ destinationFrame: CGRect?) {
        self.destinationFrame = destinationFrame
    }
	
	func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return BrowserTransitionAnimator(placeholderImage: placeholderImage, originFrame: originFrame, destinationFrame: destinationFrame)
	}
	
	func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return BrowserTransitionAnimator(placeholderImage: placeholderImage, originFrame: originFrame, destinationFrame: destinationFrame)
	}
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return BrowserCustomPresentationController(presentedViewController: presented, presenting: presenting, originFrame: originFrame, destinationFrame: destinationFrame)
    }

}
