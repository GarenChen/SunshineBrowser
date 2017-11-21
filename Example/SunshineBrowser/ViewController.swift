//
//  ViewController.swift
//  SunshineBrowser
//
//  Created by GarenChen on 11/20/2017.
//  Copyright (c) 2017 GarenChen. All rights reserved.
//

import UIKit
import SunshineBrowser

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//		let models = [
//			BrowserPreviewModel.imageURLString("https://f11.baidu.com/it/u=2220363683,1421487115&fm=72", nil),
//			BrowserPreviewModel.imageURLString("https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3164003869,897941581&fm=27&gp=0.jpg", nil),
//			BrowserPreviewModel.imageURLString("https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3007337475,2080397777&fm=27&gp=0.jpg", nil),
//			BrowserPreviewModel.imageURLString("https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=1340401930,138528584&fm=27&gp=0.jpg", nil),
//			BrowserPreviewModel.imageURLString("https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=4088053820,899019662&fm=27&gp=0.jpg", nil)
//			]
//
//		let mix = BrowserMixPreviewController.show(in: self, models: models, originalFrame: CGRect.init(x: 0, y: 300, width: 60, height: 80), animationPlaceholderImage: nil)
		        let images = [
		            UIImage(named: "p1")!,
		            UIImage(named: "p2")!,
		            UIImage(named: "p3")!,
		            UIImage(named: "p4")!
		        ]

		        let singlePreviewController = BrowserPhotoPreviewController.show(in: self, images: images, selectedIndex: 3, originalFrame: nil)
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

