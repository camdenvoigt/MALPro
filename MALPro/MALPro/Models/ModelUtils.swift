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
        dateFormatter.setLocalizedDateFormatFromTemplate("yyyy-mm-dd")
        guard let date = dateFormatter.date(from: dateString) else {
            fatalError("ERROR: Date conversion failed due to mismatched format.")
        }
        
        return date
    }
    
    static func urlFromString(_ link: String?) -> URL? {
        guard let urlString = link else {
            return nil
        }
        
        return URL(string: urlString)
    }
}
