//
//  ResponsedataFake.swift
//  UserInfoTestRFTests
//
//  Created by Rodolphe Schnetzer on 19/11/2022.
//

import Foundation


class ResponseDataFake {
    
   
    static let responseOK = HTTPURLResponse(url: URL(string:"https://apple.com")!, statusCode: 200, httpVersion: nil, headerFields: [:])
    static let responseKO = HTTPURLResponse(url: URL(string:"https://apple.com")!, statusCode: 500, httpVersion: nil, headerFields: [:])
    
    class DataError: Error { }
    static let error = DataError()
    
    static var userCorrectData: Data {
        let bundle = Bundle(for: ResponseDataFake.self)
        let url = bundle.url(forResource: "UserData", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
    

    static let incorrectData = "erreur".data(using: .utf8)
    
}
