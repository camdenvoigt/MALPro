//
//  Person.swift
//  MALPro
//
//  Created by Camden Voigt on 3/23/18.
//  Copyright © 2018 MALPro. All rights reserved.
//

import Foundation

public class AnimePerson {
    var id: Int
    var canonicalLink: URL?
    var name: String?
    var givenName: String?
    var familyName: String?
    var birthday: String?
    var language: String?
    var websiteUrl: URL?
    var favorites: Int?
    var moreInfo: String?
    var imageUrl: URL?
    var roles: [VoiceActingRole]?
    var roleString: String?
    
    init(id: Int) {
        self.id = id
    }
    
    // For Constructing full person from json
    init(data: Any) throws {
        guard let json = data as? Dictionary<String, Any> else {
            throw NetworkError.JSONCastError("Could not cast data object for Anime object")
        }
        
        self.id = json["mal_id"] as! Int
        self.canonicalLink = ModelUtils.urlFromString(json["link_canonical"] as? String)
        self.name = json["name"] as? String
        self.givenName = json["given_name"] as? String
        self.familyName = json["family_name"] as? String
        self.birthday = json["birthday"] as? String
        self.websiteUrl = ModelUtils.urlFromString(json["website_url"] as? String)
        self.moreInfo = json["more"] as? String
        self.imageUrl = ModelUtils.urlFromString(json["image_url"] as? String)
        if let voiceActingRoles = json["voice_acting_role"] as? [[String: Any?]] {
            for role in voiceActingRoles {
                if let anime = role["anime"] as? [String: Any?],
                    let character = role["character"] as? [String: Any?]
                {
                    roles?.append(VoiceActingRole(Anime(dict: anime, search: false), AnimeCharacter(dict: character)))
                }
            }
        }
    }
    
    // For constructing partial person from characters and search results
    init(dict: [String: Any?], search: Bool) {
        self.id = (search) ? dict["id"] as! Int : dict["mal_id"] as! Int
        self.name = dict["name"] as? String
        self.roleString = dict["role"] as? String
        self.canonicalLink = ModelUtils.urlFromString(dict["url"] as? String)
        self.language = dict["language"] as? String
        self.imageUrl = ModelUtils.urlFromString(dict["image_url"] as? String)
    }
}
