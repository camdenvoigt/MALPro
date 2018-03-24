//
//  DataResponse+XML.swift
//  MALPro
//
//  Created by Camden Voigt on 3/24/18.
//  Copyright © 2018 MALPro. All rights reserved.
//

import Foundation
import Alamofire
import Fuzi

extension DataRequest {
    static func xmlResponseSerializer() -> DataResponseSerializer<XMLDocument> {
        return DataResponseSerializer { request, response, data, error in
            // Pass through any underlying URLSession error to the .network case.
            guard error == nil else {
                return .failure(error!)
            }
            
            // Use Alamofire's existing data serializer to extract the data, passing the error as nil, as it has
            // already been handled.
            let result = Request.serializeResponseData(response: response, data: data, error: nil)
            
            guard case let .success(validData) = result else {
                return .failure(result.error!)
            }
            
            do {
                let xml = try XMLDocument(data: validData)
                return .success(xml)
            } catch {
                return .failure(error)
            }
        }
    }
    
    @discardableResult
    func responseXMLDocument(
        queue: DispatchQueue? = nil,
        completionHandler: @escaping (DataResponse<XMLDocument>) -> Void)
        -> Self
    {
        return response(
            queue: queue,
            responseSerializer: DataRequest.xmlResponseSerializer(),
            completionHandler: completionHandler
        )
    }
}
