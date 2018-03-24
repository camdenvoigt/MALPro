//
//  Person.swift
//  MALPro
//
//  Created by Camden Voigt on 3/23/18.
//  Copyright © 2018 MALPro. All rights reserved.
//

import Foundation

public class Person {
    var id: Int
    var canonicalLink: URL?
    var name: String?
    var givenName: String?
    var familyName: String?
    var birthday: Date?
    var websiteUrl: URL?
    var favorites: Int?
    var moreInfo: String?
    var imageUrl: URL?
    
    init(id: Int) {
        self.id = id
    }
}
