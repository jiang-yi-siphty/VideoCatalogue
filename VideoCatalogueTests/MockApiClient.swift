//
//  MockApiClient.swift
//  VideoCatalogueTests
//
//  Created by Yi JIANG on 29/10/18.
//  Copyright © 2018 Siphty. All rights reserved.
//

import Foundation

class MockApiClient: ApiClient {
    
    enum JsonFileName: String {
        case vcResponse_correct = "VideoCatalogueAPIResponse"
        case vcResponse_empty = "VideoCatalogueAPIResponse_empty"
        case vcResponse_incorrect = "VideoCatalogueAPIResponse_incorrect"
    }
    
    var jsonFileName: JsonFileName = .vcResponse_correct
    
    //Use mock response data
    override func networkRequest(_ config: ApiConfig, completionHandler: @escaping ((Data?, RequestError?) -> Void)) {
        guard let jsonData = JsonFileLoader.loadJson(fileName: jsonFileName.rawValue) else {
            completionHandler(nil, RequestError("Video Catalogue information failed."))
            return
        }
        completionHandler(jsonData, nil)
    }
}

class JsonFileLoader {
    
    class func loadJson(fileName: String) -> Data? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                return try NSData(contentsOf: url) as Data
            } catch let error {
                print("Error!! Unable to parse  \(fileName).json\n error: \(error)")
            }
            print("Error!! Unable to load  \(fileName).json")
        } else {
            print("invalid url")
        }
        return nil
    }
}
