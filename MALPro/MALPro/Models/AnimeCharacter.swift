//
//  Character.swift
//  MALPro
//
//  Created by Camden Voigt on 3/23/18.
//  Copyright © 2018 MALPro. All rights reserved.
//

import UIKit

enum CharacterType: String {
    case main = "Main"
    case supporting = "Supporting"
}

public class AnimeCharacter: ImageCollectible {
    
    var id: Int
    var canonicalLink: URL?
    var name: String?
    var nameJapanese: String?
    var about: String?
    var favorites: Int?
    var image: UIImage?
    var imageUrl: URL?
    var voiceActors: [AnimePerson]?
    var role: CharacterType?
    
    init(id: Int) {
        self.id = id
    }
    
    // For constructing full Character from json
    init(data: Any) throws {
        guard let json = data as? Dictionary<String, Any> else {
            throw NetworkError.JSONCastError("Could not cast data object for Anime object")
        }
        
        self.id = json["mal_id"] as! Int
        self.canonicalLink = ModelUtils.urlFromString(json["link_canonical"] as? String)
        self.name = json["name"] as? String
        self.nameJapanese = json["name_kanji"] as? String
        self.about = json["about"] as? String
        self.favorites = json["member_favorites"] as? Int
        self.imageUrl = ModelUtils.urlFromString(json["image_url"] as? String)
        if let voiceActors = json["voice_actor"] as? [Dictionary<String, Any>] {
            for voiceActor in voiceActors {
                self.voiceActors?.append(AnimePerson(dict: voiceActor, search: false))
            }
        }
    }
    
    // For constructing partial character from Person
    init(dict: [String : Any?]) {
        self.id = dict["mal_id"] as! Int
        self.name = dict["name"] as? String
        self.canonicalLink = ModelUtils.urlFromString(dict["url"] as? String)
        self.imageUrl = ModelUtils.urlFromString(dict["image_url"] as? String)
        self.role = characterTypeFromString(dict["role"] as? String)
    }
    
    private func characterTypeFromString(_ value: String?) -> CharacterType? {
        guard let value = value else {
            return nil
        }
        
        switch value {
            case "Main":
                return CharacterType.main
            case "Supporting":
                return CharacterType.supporting
            default:
                return CharacterType.supporting
        }
    }
    
    //MARK: - ImageCollectible Methods
    
    func getLabel() -> String? {
        return name
    }
    
    func getSubLabel() -> String? {
        //TODO: Fix this to return the actual character type
        return "Main"
    }
}
