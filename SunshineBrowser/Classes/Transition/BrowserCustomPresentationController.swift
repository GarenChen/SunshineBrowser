//
//  BrowserCustomPresentationController
//  SunshineBrowser
//
//  Created by ChenGuangchuan on 2017/11/14.
//  Copyright © 2017年 cgc. All rights reserved.
//

import Foundation
import UIKit

class BrowserCustomPresentationController: UIPresentationController {

    private var originFrame: CGRect?
    
    private var destinationFrame: CGRect?
    
    private lazy var dimmingView: UIView = { [unowned self] in
        let dimmingView = UIView()
        dimmingView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        dimmingView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapDimmingView(_:))))
        return dimmingView
    }()
    
    convenience init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?, originFrame: CGRect?, destinationFrame: CGRect?) {
        self.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        self.originFrame = originFrame
        self.destinationFrame = destinationFrame
    }
    
    private override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
    }
    
    override func presentationTransitionWillBegin() {
        guard let containerView = containerView else { return }
        containerView.addSubview(dimmingView)
        dimmingView.frame = containerView.bounds
        dimmingView.alpha = 0
        _ = presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (coordinatorContex) in
            self.dimmingView.alpha = 1
        }, completion: nil)
    }
    
    override func dismissalTransitionWillBegin() {
        _ = presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (coodinatorContex) in
            self.dimmingView.alpha = 0
        }, completion: nil)
    }
    
    override func containerViewWillLayoutSubviews() {
        guard let containerView = containerView else { return }
        dimmingView.frame = containerView.bounds
        presentedView?.frame = destinationFrame ?? containerView.bounds
    }
    
    @objc private func didTapDimmingView(_ sender: UITapGestureRecognizer) {
        presentedViewController.dismiss(animated: true, completion: nil)
    }
    
}

