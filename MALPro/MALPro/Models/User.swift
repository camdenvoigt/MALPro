//
//  User.swift
//  MALPro
//
//  Created by Camden Voigt on 3/24/18.
//  Copyright © 2018 MALPro. All rights reserved.
//

import Foundation

public class User {
    var id: Int
    var username: String
    var animeList: AnimeList?
    
    init(id: Int, username: String) {
        self.id = id
        self.username = username
    }
}
