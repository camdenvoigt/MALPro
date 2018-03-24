//
//  Episode.swift
//  MALPro
//
//  Created by Camden Voigt on 3/23/18.
//  Copyright © 2018 MALPro. All rights reserved.
//

import Foundation

public class Episode {
    var id: Int
    var title: String?
    var titleJapanese: String?
    var titleRomanji: String?
    var aired: String?
    var filler: Bool?
    var recap: Bool?
    var video_url: URL?
    var forum_url: URL?
    
    init(id: Int) {
        self.id = id
    }
    
    init(dict: [String: Any?]) {
        self.id = dict["id"] as! Int
        self.title = dict["title"] as? String
        self.titleJapanese = dict["title_japanese"] as? String
        self.titleRomanji = dict["title_romanji"] as? String
        self.aired = dict["aired"] as? String
        self.filler = dict["filler"] as? Bool
        self.recap = dict["recap"] as? Bool
        self.video_url = ModelUtils.urlFromString(dict["video_url"] as? String)
        self.forum_url = ModelUtils.urlFromString(dict["forum_url"] as? String)
    }
}
