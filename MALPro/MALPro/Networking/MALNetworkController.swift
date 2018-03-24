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
    func getCharacters(id: Int, completionHandler: @escaping([AnimeCharacter]?) -> Void) -> Alamofire.DataRequest {
        return Alamofire.request("\(JIKAN_BASE_URL)/anime/\(id)/characters").responseJSON { response in
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
}
