//
//  Anime.swift
//  MALPro
//
//  Created by Camden Voigt on 3/23/18.
//  Copyright © 2018 MALPro. All rights reserved.
//

import Foundation
import UIKit

enum AnimeType {
    case tv
    case movie
    case ova
    case special
    case music
    case none
}

enum AnimeSourceType {
    case original
    case manga
    case novel
    case lightNovel
}

enum AnimeStatus: String {
    case notAdded = "Not in List"
    case watching = "Watching"
    case completed = "Completed"
    case onHold = "On Hold"
    case dropped = "Dropped"
    case planToWatch = "Plan to Watch"
}

public class Anime {
    
    // Main Values
    var id: Int
    var allData: Bool
    var canonicalLink: URL?
    var title: String?
    var titleJapanese: String?
    var imageUrl: URL?
    var image: UIImage?
    var type: AnimeType?
    var source: AnimeSourceType?
    var episodeCount: Int?
    var status: String?
    var airing: Bool?
    var airDate: String?
    var startDate: Date?
    var endDate: Date?
    var duration: String?
    var rating: String?
    var score: Double?
    var rank: Int?
    var popularity: Int?
    var members: Int?
    var favorites: Int?
    var synopsis: String?
    var background: String?
    var premiered: String?
    var broadcast: String?
    
    // Collections
    var characters: [AnimeCharacter]?
    var episodes: [AnimeEpisode]?
    var staff: [AnimePerson]?
    var studios: [String]?
    var genres: [String]?
    
    // User Values
    var episodesWatched: Int?
    var userStartDate: Date?
    var userEndDate: Date?
    var userScore: Int?
    var userStatus: AnimeStatus?
    
    init(id: Int) {
        self.id = id
        allData = false
    }
    
    init(data: Any) throws {
        guard let json = data as? Dictionary<String, Any> else {
            throw NetworkError.JSONCastError("Could not cast data object for Anime object")
        }
        
        self.id = json["mal_id"] as! Int
        self.allData = true
        self.canonicalLink = ModelUtils.urlFromString(json["link_canonical"] as? String)
        self.title = json["title"] as? String
        self.titleJapanese = json["title_japanese"] as? String
        self.imageUrl = ModelUtils.urlFromString(json["image_url"] as? String)
        self.type = animeTypeFromString(json["type"] as? String)
        self.source = sourceTypeFromString(json["source"] as? String)
        self.episodeCount = json["episodes"] as? Int
        self.status = json["status"] as? String
        self.airing = json["airing"] as? Bool
        self.airDate = json["aired_string"] as? String
        if let aired = json["aired"] as? Dictionary<String, Any> {
            self.startDate = ModelUtils.dateFromString(aired["from"] as? String)
            self.endDate = ModelUtils.dateFromString(aired["to"] as? String)
        }
        self.duration = json["duration"] as? String
        self.rating = json["rating"] as? String
        self.score = json["score"] as? Double
        self.rank = json["rank"] as? Int
        self.popularity = json["popularity"] as? Int
        self.members = json["members"] as? Int
        self.favorites = json["favorites"] as? Int
        self.synopsis = String(utf8String: ((json["synopsis"] as? String)?.cString(using: String.Encoding.utf8))!)
        self.background = json["background"] as? String
        self.premiered = json["premiered"] as? String
        self.broadcast = json["boradcast"] as? String
        if let studioList = json["studio"] as? [[String: Any]] {
            self.studios = [String]()
            for studio in studioList {
                self.studios!.append((studio["name"] as? String)!)
            }
        }
        if let genreList = json["genre"] as? [[String: Any]] {
            self.genres = [String]()
            for genre in genreList {
                self.genres!.append((genre["name"] as? String)!)
            }
        }
        if let characters = json["character"] as? [[String: Any?]] {
            self.characters = [AnimeCharacter]()
            for character in characters {
                self.characters!.append(AnimeCharacter(dict: character))
            }
        }
        if let episodes = json["episode"] as? [[String: Any?]] {
            self.episodes = [AnimeEpisode]()
            for episode in episodes {
                self.episodes!.append(AnimeEpisode(dict: episode))
            }
        }
        if let people = json["staff"] as? [[String: Any?]] {
            self.staff = [AnimePerson]()
            for person in people {
                self.staff!.append(AnimePerson(dict: person, search: false))
            }
        }
    }
    
    // For constructing partial anime from Person and Search Results
    init(dict: [String : Any?], search: Bool) {
        self.id = (search) ? dict["id"] as! Int : dict["mal_id"] as! Int
        self.allData = false
        self.title = dict["name"] as? String
        self.canonicalLink = ModelUtils.urlFromString(dict["url"] as? String)
        self.imageUrl = ModelUtils.urlFromString(dict["image_url"] as? String)
        
        self.synopsis = dict["description"] as? String
        self.score = dict["score"] as? Double
        self.episodeCount = dict["episodes"] as? Int
        self.members = dict["members"] as? Int
    }
    
    func updateAnimeFromAnime(anime: Anime) {
        self.allData = true
        self.canonicalLink = anime.canonicalLink
        self.title = anime.title
        self.titleJapanese = anime.titleJapanese
        self.imageUrl = anime.imageUrl
        self.type = anime.type
        self.source = anime.source
        self.episodeCount = anime.episodeCount
        self.status = anime.status
        self.airing = anime.airing
        self.airDate = anime.airDate
        self.startDate = anime.startDate
        self.endDate = anime.endDate
        self.duration = anime.duration
        self.rating = anime.rating
        self.score = anime.score
        self.rank = anime.rank
        self.popularity = anime.popularity
        self.members = anime.members
        self.favorites = anime.favorites
        self.synopsis = anime.synopsis
        self.background = anime.background
        self.premiered = anime.premiered
        self.broadcast = anime.broadcast
        self.characters = anime.characters
        self.episodes = anime.episodes
        self.staff = anime.staff
        self.genres = anime.genres
        self.studios = anime.studios
    }
    
    private func animeTypeFromString(_ type: String?) ->  AnimeType? {
        guard let typeString = type else {
            return nil
        }
        
        switch typeString {
            case "TV":
                return AnimeType.tv
            case "Movie":
                return AnimeType.movie
            case "OVA":
                return AnimeType.ova
            case "Special":
                return AnimeType.special
            case "Music":
                return AnimeType.music
            default:
                return AnimeType.none
        }
    }
    
    private func sourceTypeFromString(_ type: String?) -> AnimeSourceType? {
        guard let typeString = type else {
            return nil
        }
        
        switch typeString {
            case "Original":
                return AnimeSourceType.original
            case "Manga":
                return AnimeSourceType.manga
            case "Novel":
                return AnimeSourceType.novel
            case "LightNovel":
                return AnimeSourceType.lightNovel
            default:
                return AnimeSourceType.original
        }
    }
}

// MARK - User Info

extension Anime {
    // Initalize Anime from User's list
    convenience init(list dict: [String: Any?]) {
        self.init(id: 0)
        
        self.id = dict["id"] as! Int
        self.title = dict["title"] as? String
        self.imageUrl = ModelUtils.urlFromString(dict["image_url"] as? String)
        self.episodeCount = dict["episodes"] as? Int
        
        self.episodesWatched = dict["episodes_watched"] as? Int
        self.userStartDate = ModelUtils.dateFromString(dict["user_start"] as? String)
        self.userEndDate = ModelUtils.dateFromString(dict["user_end"] as? String)
        self.userScore = dict["user_score"] as? Int
        self.userStatus = intToUserStatus(dict["user_status"] as! Int)
    }
    
    private func intToUserStatus(_ val: Int) -> AnimeStatus {
        switch val {
            case 0:
                return .notAdded
            case 1:
                return .watching
            case 2:
                return .completed
            case 3:
                return .onHold
            case 4:
                return .dropped
            case 5:
                return .planToWatch
            default:
                return .notAdded
        }
    }
}
