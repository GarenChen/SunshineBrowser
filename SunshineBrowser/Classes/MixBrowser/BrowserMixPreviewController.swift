//
//  BrowserMixPreviewController.swift
//  SunshineBrowser
//
//  Created by ChenGuangchuan on 2017/11/19.
//  Copyright © 2017年 cgc. All rights reserved.
//

import UIKit

public class BrowserMixPreviewController: BaseGestureAnimationController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var models: [BrowserPreviewModel] = []
    
    var currentItemIndex: Int = 0
    
    static var controllerViewFrame: CGRect {
        return UIScreen.main.bounds
    }

    override var animationPlaceholderImage: UIImage? {
        return (collectionView.cellForItem(at: IndexPath(item: currentItemIndex, section: 0)) as? PreviewContentType)?.animationPlaceholderImage
    }
    
    override var handlingView: UIView? {
        return (collectionView.cellForItem(at: IndexPath(item: currentItemIndex, section: 0)) as? PreviewContentType)?.handlingView
    }

	@discardableResult
	public class func show(in controller: UIViewController, models: [BrowserPreviewModel], selectedIndex: Int = 0, originalFrame: CGRect?, animationPlaceholderImage: UIImage?, config: BrowserConfig = BrowserConfig()) -> BrowserMixPreviewController {
		
		BrowserConfig.shared.imageLoader = config.imageLoader
		BrowserConfig.shared.videoLoader = config.videoLoader
		BrowserConfig.shared.imageProgressIndicator = config.imageProgressIndicator
		BrowserConfig.shared.videoProgressIndicator = config.videoProgressIndicator
		
        let storyboard = UIStoryboard(name: "Browser", bundle: Bundle.current)
        let previewController = storyboard.instantiateViewController(withIdentifier: "BrowserMixPreviewController") as! BrowserMixPreviewController
        
        previewController.modalPresentationStyle = .custom

        previewController.customTransitionDelegate = BrowserTransitionDelegate(placeholderImage: animationPlaceholderImage, originFrame: originalFrame, destinationFrame: BrowserMixPreviewController.controllerViewFrame)
        previewController.models = models
        previewController.currentItemIndex = selectedIndex
		
		controller.present(previewController, animated: true, completion: nil)
		
        return previewController
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override var prefersStatusBarHidden: Bool {
        return true
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        title = " "
        
        if #available(iOS 11, *) {
            collectionView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
    }
	
	public override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		if currentItemIndex < models.count {
			view.layoutIfNeeded()
			let collectionViewWidth = BrowserMixPreviewController.controllerViewFrame.size.width + 20
			collectionView.setContentOffset(CGPoint.init(x: collectionViewWidth * CGFloat(currentItemIndex), y: 0), animated: false)
		}
	}
    
    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - UICollectionViewDataSource, UICollectionViewDelegate
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let model = models[indexPath.item]
        
        switch model {
        case .image(let image):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoPreviewCell", for: indexPath) as! PhotoPreviewCell
            cell.image = image
            cell.tapConentToHideBar = { [weak self] in
                self?.dismiss(animated: true, completion: nil)
            }
            return cell
			
		case let .imageURLString(urlString, image):
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoPreviewCell", for: indexPath) as! PhotoPreviewCell
			cell.model = (urlString, image)
			cell.tapConentToHideBar = { [weak self] in
				self?.dismiss(animated: true, completion: nil)
			}
			return cell
        }

    }
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        for cell in collectionView.visibleCells {
            (cell as? PreviewContentType)?.recoverSubview()
        }
        
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: BrowserMixPreviewController.controllerViewFrame.size.width + 20, height:  BrowserMixPreviewController.controllerViewFrame.size.height)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetWidth = scrollView.contentOffset.x + collectionView.frame.size.width * 0.5
        let currentItem = Int(offsetWidth / collectionView.frame.size.width)
        if currentItemIndex != currentItem {
            currentItemIndex = currentItem
            
        }
    }

}
