//
//  SinglePhotoPreviewCell.swift
//  SunshineBrowser
//
//  Created by Garen on 2017/11/13.
//  Copyright © 2017年 cgc. All rights reserved.
//

import UIKit

class SinglePhotoPreviewCell: UICollectionViewCell {
	
	@IBOutlet weak var imageView: UIImageView!
	
	var image: UIImage? {
		didSet {
			imageView.image = image ?? UIImage.named("placeholderImage.png")
		}
	}

	override func awakeFromNib() {
		super.awakeFromNib()
	}

}
