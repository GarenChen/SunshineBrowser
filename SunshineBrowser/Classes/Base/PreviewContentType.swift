//
//  PreviewContentType.swift
//  SunshineBrowser
//
//  Created by ChenGuangchuan on 2017/11/19.
//  Copyright © 2017年 cgc. All rights reserved.
//

import Foundation

protocol PreviewContentType: class {
    
    var handlingView: UIView? { get }
	var animationPlaceholderImage: UIImage? { get }
    func recoverSubview()
}
