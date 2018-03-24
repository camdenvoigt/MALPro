//
//  MALNetworkController.swift
//  MALPro
//
//  Created by Camden Voigt on 3/23/18.
//  Copyright © 2018 MALPro. All rights reserved.
//

import Foundation
import Alamofire

public class MALNetworkController {
    
    let JIKAN_BASE_URL = "https://api.jikan.me"
    let MAL_BASE_URL = "https://myanimelist.net"
    
    // Get UIImage for image url
    @discardableResult
    func getImage(url: URL,completionHandler: @escaping(UIImage?) -> Void) -> Alamofire.DataRequest {
        return Alamofire.request(url).responseData { response in
            if let data = response.value {
                completionHandler(UIImage(data: data))
            } else {
                completionHandler(nil)
            }
        }
    }
    
    // Get anime list by id
    @discardableResult
    func getAnime(id: Int, completionHandler: @escaping(Anime?) -> Void) -> Alamofire.DataRequest {
        return Alamofire.request("\(JIKAN_BASE_URL)/anime/\(id)").responseJSON { response in
            let animeResponse = response.flatMap { json in
                try Anime(data: json)
            }
            
            completionHandler(animeResponse.value)
        }
    }
    
    // Get all characters from a given anime
    @discardableResult
    func getAnimeCharacters(animeId: Int, completionHandler: @escaping([AnimeCharacter]?) -> Void) -> Alamofire.DataRequest {
        return Alamofire.request("\(JIKAN_BASE_URL)/anime/\(animeId)/characters_staff").responseJSON { response in
            let animeResponse = response.flatMap { json in
                try Anime(data: json)
            }

            if let anime = animeResponse.value
            {
                completionHandler(anime.characters)
            } else {
                completionHandler(nil)
            }
        }
    }
    
    // Get all episodes from a given anime
    @discardableResult
    func getAnimeEpisodes(animeId: Int, completionHandler: @escaping([AnimeEpisode]?) -> Void) -> Alamofire.DataRequest {
        return Alamofire.request("\(JIKAN_BASE_URL)/anime/\(animeId)/episodes").responseJSON { response in
            let animeResponse = response.flatMap { json in
                try Anime(data: json)
            }
            
            if let anime = animeResponse.value
            {
                completionHandler(anime.episodes)
            } else {
                completionHandler(nil)
            }
        }
    }
    
    // Get all episodes from a given anime
    @discardableResult
    func getAnimePeople(animeId: Int, completionHandler: @escaping([AnimePerson]?) -> Void) -> Alamofire.DataRequest {
        return Alamofire.request("\(JIKAN_BASE_URL)/anime/\(animeId)/characters_staff").responseJSON { response in
            let animeResponse = response.flatMap { json in
                try Anime(data: json)
            }
            
            if let anime = animeResponse.value
            {
                completionHandler(anime.staff)
            } else {
                completionHandler(nil)
            }
        }
    }
    
    // Get a single person with full data
    @discardableResult
    func getAnimePerson(personId: Int, completionHandler: @escaping(AnimePerson?) -> Void) -> Alamofire.DataRequest {
        return Alamofire.request("\(JIKAN_BASE_URL)/person/\(personId)").responseJSON { response in
            let personResponse = response.flatMap { json in
                try AnimePerson(data: json)
            }
            
            completionHandler(personResponse.value)
        }
    }
    
    // Get a single character with full data
    @discardableResult
    func getAnimeCharacter(characterId: Int, completionHandler: @escaping(AnimeCharacter?) -> Void) -> Alamofire.DataRequest {
        return Alamofire.request("\(JIKAN_BASE_URL)/character/\(characterId)").responseJSON { response in
            let characterResponse = response.flatMap { json in
                try AnimeCharacter(data: json)
            }
            
            completionHandler(characterResponse.value)
        }
    }
    
    // Do a search of all anime
    @discardableResult
    func searchAnime(query: String, pageNumber: Int, completionHandler: @escaping([Anime]?) -> Void) -> Alamofire.DataRequest {
        let cleanedQuery = query.replacingOccurrences(of: " ", with: "+")
        return Alamofire.request("\(JIKAN_BASE_URL)/search/anime/\(cleanedQuery)/\(pageNumber)").responseJSON { response in
            guard let json = response.value as? [String: Any] else {
                return completionHandler(nil)
            }
            
            var searchResults = [Anime]()
            if let results = json["result"] as? [[String: Any?]] {
                for result in results {
                    searchResults.append(Anime(dict: result, search: true))
                }
            }
            
            completionHandler(searchResults)
        }
    }
    
    // Do a search of all people
    @discardableResult
    func searchPeople(query: String, pageNumber: Int, completionHandler: @escaping([AnimePerson]?) -> Void) -> Alamofire.DataRequest {
        let cleanedQuery = query.replacingOccurrences(of: " ", with: "+")
        return Alamofire.request("\(JIKAN_BASE_URL)/search/people/\(cleanedQuery)/\(pageNumber)").responseJSON { response in
            guard let json = response.value as? [String: Any] else {
                return completionHandler(nil)
            }
            
            var searchResults = [AnimePerson]()
            if let results = json["result"] as? [[String: Any?]] {
                for result in results {
                    searchResults.append(AnimePerson(dict: result, search: true))
                }
            }
            
            completionHandler(searchResults)
        }
    }
    
    // Sign a user in
    @discardableResult
    func userAuthentication(username: String, password: String, completionHandler: @escaping(User?) -> Void) -> Alamofire.DataRequest {
        return Alamofire.request("\(MAL_BASE_URL)/api/account/verify_credentials.xml").authenticate(user: username, password: password).responseXMLDocument { response in
            guard let xmlDocument = response.value else {
                completionHandler(nil)
                return
            }
            
            if let root = xmlDocument.root {
                let id = root.firstChild(tag: "id")?.numberValue
                let username = root.firstChild(tag: "username")?.stringValue
                completionHandler(User(id: (id?.intValue)!, username: username!))
            } else {
                completionHandler(nil)
            }
        }
    }
    
    // Get entire animelist of user
    @discardableResult
    func userAnimeList(username: String, completionHandler: @escaping(AnimeList?) -> Void) -> Alamofire.DataRequest {
        return Alamofire.request("\(MAL_BASE_URL)/malappinfo.php?u=\(username)&status=all&type=anime").responseXMLDocument { response in
            guard let xmlDocument = response.value else {
                completionHandler(nil)
                return
            }
            
            guard let root = xmlDocument.root else {
                completionHandler(nil)
                return
            }
            
            completionHandler(XMLHelpers.convertXMLToAnimeList(root: root))
        }
    }
    
    // Add anime to user's anime list
    @discardableResult
    func addAnimeToList(username: String, password: String, anime: Anime, completionHandler: @escaping(Bool) -> Void) -> Alamofire.DataRequest {
        let params = XMLHelpers.createXMLParameters(anime: anime)
        return Alamofire.request("\(MAL_BASE_URL)/api/animelist/add/\(anime.id).xml", method: .post, parameters: params).authenticate(user: username, password: password).responseString { response in
            guard let response = response.value else {
                completionHandler(false)
                return
            }
            
            if response == "Created" {
                completionHandler(true)
            } else {
                completionHandler(false)
            }
        }
    }
    
    // Update an anime entry on a user's anime list
    @discardableResult
    func updateAnimeOnList(username: String, password: String, anime: Anime, completionHandler: @escaping(Bool) -> Void) -> Alamofire.DataRequest {
        let params = XMLHelpers.createXMLParameters(anime: anime)
        return Alamofire.request("\(MAL_BASE_URL)/api/animelist/update/\(anime.id).xml", method: .post, parameters: params).authenticate(user: username, password: password).responseString { response in
            guard let response = response.value else {
                completionHandler(false)
                return
            }
            
            if response == "Updated" {
                completionHandler(true)
            } else {
                completionHandler(false)
            }
        }
    }
    
    // Delete an anime entry on a user's anime list
    @discardableResult
    func deleteAnimeFromList(username: String, password: String, anime: Anime, completionHandler: @escaping(Bool) -> Void) -> Alamofire.DataRequest {
        let params = XMLHelpers.createXMLParameters(anime: anime)
        return Alamofire.request("\(MAL_BASE_URL)/api/animelist/add/\(anime.id).xml", method: .post, parameters: params).authenticate(user: username, password: password).responseString { response in
            guard let response = response.value else {
                completionHandler(false)
                return
            }
            
            if response == "Deleted" {
                completionHandler(true)
            } else {
                completionHandler(false)
            }
        }
    }
}
