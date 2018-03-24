//
//  Character.swift
//  MALPro
//
//  Created by Camden Voigt on 3/23/18.
//  Copyright © 2018 MALPro. All rights reserved.
//

import Foundation

public class Character {
    var id: Int
    var canonicalLink: URL?
    var name: String?
    var nameJapanese: String?
    var nicknames: String?
    var about: String?
    var favorites: Int?
    var imageUrl: URL?
    
    init(id: Int) {
        self.id = id
    }
}
