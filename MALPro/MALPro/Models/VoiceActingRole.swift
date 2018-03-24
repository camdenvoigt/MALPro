//
//  VoiceActingRole.swift
//  MALPro
//
//  Created by Camden Voigt on 3/23/18.
//  Copyright © 2018 MALPro. All rights reserved.
//

import Foundation

public class VoiceActingRole {
    var anime: Anime
    var character: Character
    
    init(_ anime: Anime, _ character: Character) {
        self.anime = anime
        self.character = character
    }
}
