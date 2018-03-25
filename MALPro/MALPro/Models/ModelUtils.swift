//
//  ModelUtils.swift
//  MALPro
//
//  Created by Camden Voigt on 3/23/18.
//  Copyright © 2018 MALPro. All rights reserved.
//

import Foundation

public class ModelUtils {
    static func dateFromString(_ dateString: String?) -> Date? {
        guard let dateString = dateString else {
            return nil
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.dateStyle = .medium
        dateFormatter.locale = Locale(identifier: "en_US")
        guard let date = dateFormatter.date(from: dateString) else {
            return nil
        }
        
        return date
    }
    
    static func urlFromString(_ link: String?) -> URL? {
        guard let urlString = link else {
            return nil
        }
        
        return URL(string: urlString)
    }
    
    static func animeStatusAsInt(status: AnimeStatus) -> Int {
        switch status {
            case .notAdded:
                return 0
            case .watching:
                return 1
            case .completed:
                return 2
            case .onHold:
                return 3
            case .dropped:
                return 4
            case .planToWatch:
                return 5
        }
    }
    
    static func fixUnicode(value: String?) -> String? {
        guard let value = value else {
            return nil
        }
        
        let encodedData = value.data(using: .utf8)
        let attributedOptions : [NSAttributedString.DocumentReadingOptionKey: Any] =
            [
                NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html,
                NSAttributedString.DocumentReadingOptionKey.characterEncoding: 4
            ]
        
        do {
            let attributedString = try NSAttributedString(data: encodedData!, options: attributedOptions, documentAttributes: nil)
            return attributedString.string
        } catch {
            return value
        }
    }
}
