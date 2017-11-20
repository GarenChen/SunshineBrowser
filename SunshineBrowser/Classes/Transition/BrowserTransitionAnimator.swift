//
//  BrowserTransitionAnimator.swift
//  SunshineBrowser
//
//  Created by Garen on 2017/11/13.
//  Copyright © 2017年 cgc. All rights reserved.
//

import UIKit

class BrowserTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {

	private var originFrame: CGRect?
    
    private var destinationFrame: CGRect?
    
    private var placeholderImage: UIImage?
    
    private lazy var animationHolderImageview: UIImageView = {
        let holderImageView = UIImageView()
        holderImageView.contentMode = .scaleAspectFit
        return holderImageView
    }()

	convenience init(placeholderImage: UIImage?, originFrame: CGRect?, destinationFrame: CGRect?) {
		self.init()
		self.originFrame = originFrame
        self.destinationFrame = destinationFrame
		self.placeholderImage = placeholderImage
	}
	
	private override init() {
		super.init()
	}

	func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
		return 0.3
	}

	func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let fromViewController = transitionContext.viewController(forKey: .from) else {
            return
        }
        guard let toViewController = transitionContext.viewController(forKey: .to) else {
			return
		}
        guard let fromView = fromViewController.view else {
            return
        }
        guard let toView = toViewController.view else {
            return
        }
		
		let containerView = transitionContext.containerView

		let isPresenting = toViewController.presentingViewController == fromViewController

        let containerBounds = containerView.bounds
        let originFrame = self.originFrame ?? CGRect(x: containerBounds.origin.x / 2, y: containerBounds.origin.y / 2, width: 1, height: 1)
        
        let duration = transitionDuration(using: transitionContext)

		if isPresenting {
            containerView.addSubview(toView)
			toView.frame = self.destinationFrame ?? containerBounds
            toView.alpha = 0

            animationHolderImageview.image = placeholderImage ?? UIImage.named("placeholderImage.png")
            animationHolderImageview.frame = originFrame
            containerView.addSubview(animationHolderImageview)
            
            UIView.animate(withDuration: duration, animations: {
                self.animationHolderImageview.frame = self.destinationFrame ?? containerBounds
            }, completion: { _ in
                self.animationHolderImageview.removeFromSuperview()
                toView.alpha = 1
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
			
		} else {
            fromView.alpha = 0
            
            animationHolderImageview.image = placeholderImage ?? UIImage.named("placeholderImage.png")
            animationHolderImageview.frame = destinationFrame ?? transitionContext.initialFrame(for: fromViewController)
            containerView.addSubview(animationHolderImageview)
            
            UIView.animate(withDuration: duration, animations: {
                self.animationHolderImageview.frame = originFrame
            }, completion: { _ in
                self.animationHolderImageview.removeFromSuperview()
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
		}
	}
}
