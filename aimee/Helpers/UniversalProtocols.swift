//
//  UniversalProtocols.swift
//  Catalogue
//
//  Created by Chandrachudh on 02/02/18.
//  Copyright © 2018 F22Labs. All rights reserved.
//

import Foundation
import UIKit

@objc protocol AMMemberToggleSelectionToggleDelegate:class {
    @objc optional func didToggleConnectionAt(indexPath:IndexPath)
    @objc optional func didToggleConnectionAt(indexPath:IndexPath, collectionView:UICollectionView)
}
