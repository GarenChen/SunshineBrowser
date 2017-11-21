//
//  BrowserPhotoPreviewController.swift
//  SunshineBrowser
//
//  Created by Garen on 2017/11/13.
//  Copyright © 2017年 cgc. All rights reserved.
//

import UIKit

public class BrowserPhotoPreviewController: BaseGestureAnimationController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
	
	@IBOutlet weak var collectionView: UICollectionView!
	
	@IBOutlet weak var pageControl: UIPageControl!
    
    private var images: [UIImage] = []
    
    private var selectedIndex: Int = 0

    static var controllerViewFrame: CGRect {
        return UIScreen.main.bounds.insetBy(dx: 15, dy: 15)
    }
	
    override var animationPlaceholderImage: UIImage? {
        return images[selectedIndex]
    }
    
    override var handlingView: UIView? {
        return (collectionView.cellForItem(at: IndexPath(item: selectedIndex, section: 0)) as! SinglePhotoPreviewCell).imageView
    }
	
	public override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 11, *) {
            collectionView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        (self.presentationController as? BrowserCustomPresentationController)?.dimmingView.backgroundColor = UIColor(white: 0, alpha: 0.5)
		pageControl.numberOfPages = images.count
    }
	
	public override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		if selectedIndex < images.count {
			view.layoutIfNeeded()
			pageControl.currentPage = selectedIndex
			let collectionViewWidth = BrowserPhotoPreviewController.controllerViewFrame.size.width + 20
			collectionView.setContentOffset(CGPoint.init(x: collectionViewWidth * CGFloat(selectedIndex), y: 0), animated: false)
		}
	}

	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
	}
	
	public required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	@discardableResult
    public class func show(in controller: UIViewController, images: [UIImage], selectedIndex: Int = 0, originalFrame: CGRect?) -> BrowserPhotoPreviewController {
		let storyboard = UIStoryboard(name: "Browser", bundle: Bundle.current)
		let previewController = storyboard.instantiateViewController(withIdentifier: "BrowserPhotoPreviewController") as! BrowserPhotoPreviewController
		
		previewController.modalPresentationStyle = .custom
		previewController.customTransitionDelegate = BrowserTransitionDelegate(placeholderImage: images[selectedIndex], originFrame: originalFrame, destinationFrame: BrowserPhotoPreviewController.controllerViewFrame)
		
		previewController.images = images
		previewController.selectedIndex = selectedIndex
		
		controller.present(previewController, animated: true, completion: nil)
		
		return previewController
	}

    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	public func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	
	public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return images.count
	}

	public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let image = images[indexPath.item]
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SinglePhotoPreviewCell", for: indexPath) as! SinglePhotoPreviewCell
		cell.image = image
		return cell
	}
	
	public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        dismiss(animated: true, completion: {
            print("finish dismiss")
        })
	}
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: BrowserPhotoPreviewController.controllerViewFrame.size.width + 20, height:  BrowserPhotoPreviewController.controllerViewFrame.size.height)
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
		if selectedIndex != currentItem {
			selectedIndex = currentItem
			pageControl.currentPage = selectedIndex
		}
	}

}
