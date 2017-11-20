//
//  BaseGestureAnimationController.swift
//  SunshineBrowser
//
//  Created by ChenGuangchuan on 2017/11/19.
//  Copyright © 2017年 cgc. All rights reserved.
//

import UIKit

//protocol GestureAnimationProtocol {
//
//    var customTransitionDelegate: BrowserTransitionDelegate? { get set }
//
//    var animationImageView: UIImageView { get set }
//
//    var animationPlaceholderImage: UIImage? { get }
//
//    var handlingView: UIView { get }
//
//    func dismiss(animated flag: Bool, placeholderImage: UIImage?, animationFrame: CGRect?, completion: (() -> Void)?)
//}

public class BaseGestureAnimationController: UIViewController {
    
    var customTransitionDelegate: BrowserTransitionDelegate? {
        didSet {
            self.transitioningDelegate = customTransitionDelegate
        }
    }
    
    var animationPlaceholderImage: UIImage? {
        fatalError("Need subclass to override")
    }
    
    var handlingView: UIView? {
        fatalError("Need subclass to override")
    }
    
    private lazy var animationImageView: UIImageView = {
        let animationImageView = UIImageView()
        animationImageView.contentMode = .scaleAspectFit
        return animationImageView
    }()

    public  override func viewDidLoad() {
        super.viewDidLoad()
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(pan(_:))))
    }
    
    public  override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        self.customTransitionDelegate?.changePlaceholder(animationPlaceholderImage)
        super.dismiss(animated: flag, completion: completion)
    }
    
    @objc private func pan(_ gesture: UIPanGestureRecognizer) {
        
        guard let handlingView = handlingView else { return }
        
        let handlingViewCenter = handlingView.convert(handlingView.center, to: view)
        let handlingViewFrame = handlingView.convert(handlingView.frame, to: view)
        
        let translation = gesture.translation(in: view)
        let velocity = gesture.velocity(in: view)

        switch gesture.state {
        case .began:
            handlingView.alpha = 0
            animationImageView.image = animationPlaceholderImage
            animationImageView.frame = handlingViewFrame
            view.addSubview(animationImageView)
            view.bringSubview(toFront: animationImageView)
            view.setNeedsLayout()
            
        case .changed:
            if translation.y > 0 {
                let panRetioY = translation.y / view.bounds.size.height
                let dx = handlingViewFrame.size.width * (panRetioY < 0.75 ? panRetioY : 0.75) / 2
                let dy = handlingViewFrame.size.height * (panRetioY < 0.75 ? panRetioY : 0.75) / 2
                animationImageView.bounds = handlingViewFrame.insetBy(dx: dx, dy: dy)
            }
            animationImageView.center = CGPoint(x: handlingViewCenter.x + translation.x,
                                                y: handlingViewCenter.y + translation.y)
            
        case .ended:
            guard velocity.y <= 100 else {
                customTransitionDelegate?.changeDestinationFrame(animationImageView.frame)
                dismiss(animated: true, completion: nil)
                break
            }
            
            UIView.animate(withDuration: 0.3, animations: {
                self.animationImageView.frame = handlingViewFrame
            }, completion: { (_) in
                handlingView.alpha = 1
                self.animationImageView.removeFromSuperview()
            })
    
        case .cancelled, .failed, .possible:
            UIView.animate(withDuration: 0.3, animations: {
                self.animationImageView.frame = handlingViewFrame
            }, completion: { (_) in
                handlingView.alpha = 1
                self.animationImageView.removeFromSuperview()
            })
        }
    }

    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
