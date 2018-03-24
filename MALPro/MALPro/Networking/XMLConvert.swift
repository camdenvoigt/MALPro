//
//  XMLConvert.swift
//  MALPro
//
//  Created by Camden Voigt on 3/24/18.
//  Copyright © 2018 MALPro. All rights reserved.
//

import Foundation
import Fuzi

public class XMLConvert {
    static func convert(root: XMLElement?) -> AnimeList? {
        guard let root = root else {
            return nil
        }
        
        let list = convertAnime(myAnime: root.children(staticTag: "anime"))
        
        if let myinfo = root.firstChild(tag: "myinfo") {
            list.daysWatching = myinfo.firstChild(tag: "user_days_spent_watching")?.numberValue as? Double
        }
        
        return list
    }
    
    private static func convertAnime(myAnime: [XMLElement]) -> AnimeList {
        let list = AnimeList()
        
        for anime in myAnime {
            var basicInfo = [String: Any?]()
            
            basicInfo["id"] = anime.firstChild(tag: "series_animedb_id")?.numberValue
            basicInfo["title"] = anime.firstChild(tag: "series_title")?.stringValue
            basicInfo["episodes"] = anime.firstChild(tag: "series_episodes")?.numberValue
            basicInfo["image_url"] = anime.firstChild(tag: "series_image")?.stringValue
            basicInfo["episodes_watched"] = anime.firstChild(tag: "my_watched_episodes")?.numberValue
            basicInfo["user_start"] = anime.firstChild(tag: "my_start_date")?.stringValue
            basicInfo["user_end"] = anime.firstChild(tag: "my_finish_date")?.stringValue
            basicInfo["user_score"] = anime.firstChild(tag: "my_score")?.numberValue
            basicInfo["user_status"] = anime.firstChild(tag: "my_status")?.numberValue
            
            switch basicInfo["user_status"] as! Int {
                case 1:
                    list.watching.append(Anime(list: basicInfo))
                    list.watchingCount += 1
                case 2:
                    list.completed.append(Anime(list: basicInfo))
                    list.completedCount += 1
                case 3:
                    list.onHold.append(Anime(list: basicInfo))
                    list.onHoldCount += 1
                case 4:
                    list.dropped.append(Anime(list: basicInfo))
                    list.droppedCount += 1
                case 6:
                    list.planToWatch.append(Anime(list: basicInfo))
                    list.planToWatchCount += 1
                default:
                    break
            }
        }
        
        return list
    }
}
