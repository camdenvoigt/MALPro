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
}
