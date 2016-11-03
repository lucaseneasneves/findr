//
//  UIImage+ViewConversion.swift
//  BmwMini
//
//  Created by Victor de Lima on 11/10/16.
//  Copyright © 2016 Pedro H J Fabrino. All rights reserved.
//

import UIKit

public extension UIImage {
	
	static func convertViewToImage(view:UIView)->UIImage{
		
		UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
		
		view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
		let snapshotImageFromMyView = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		return snapshotImageFromMyView!
	}

}
