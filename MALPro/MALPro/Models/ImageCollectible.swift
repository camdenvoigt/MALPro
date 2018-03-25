//
//  ImageCollectible.swift
//  MALPro
//
//  Created by Logan Heitz on 3/24/18.
//  Copyright © 2018 MALPro. All rights reserved.
//

import UIKit

protocol ImageCollectible {
    var imageUrl: URL? { get }
    var image: UIImage? { get set }
    
    func getLabel() -> String?
    func getSubLabel() -> String?
}
