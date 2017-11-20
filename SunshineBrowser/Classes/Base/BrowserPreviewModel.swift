//
//  BrowserPreviewModel.swift
//  SunshineBrowser
//
//  Created by ChenGuangchuan on 2017/11/19.
//  Copyright © 2017年 cgc. All rights reserved.
//

import Foundation
import UIKit

public enum BrowserPreviewModel {
    case image(UIImage?)
	case imageURLString(String?, UIImage?)
    case videoURL(URL?, UIImage?)
	case videoURLString(String?, UIImage?)
}
