//
//  UsersTests.swift
//  UserInfoTestRFTests
//
//  Created by Rodolphe Schnetzer on 19/11/2022.
//

import XCTest
@testable import UserInfoTestRF

final class UsersTests: XCTestCase {
    
    override class func tearDown() {
        super.tearDown()
    
        URLProtocolStub.removeStub()
    }
    
    
    
    //OK
    func testListUsersFailedIfError() {
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolStub.self]
        let session = URLSession(configuration: configuration)
        let sub = UserNetwork(session: session)
        
        let expectation = expectation(description: "wait for request")
        
        URLProtocolStub.stub(data: nil, response: nil, error: ResponseDataFake.error )
        sub.getUser { resultat in
            switch resultat {
            case let .failure(error):
                XCTAssertNotNil(error)
            case .success:
                XCTFail("Expeted failure")
            }
        }
        
        
        expectation.fulfill()
        wait(for: [expectation], timeout: 1.0)
        
    }
    //
    func testListUserFailedIfResponseKO() {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolStub.self]
        let session = URLSession(configuration: configuration)
        let sub = UserNetwork(session: session)
        
        let expectation = expectation(description: "wait for request")
        
        URLProtocolStub.stub(data: nil, response: ResponseDataFake.responseKO, error: nil )
        sub.getUser { resultat in
            guard case .failure (let error) = resultat else {
                XCTFail("testgetExchangeReceiveResponseKO fail")
                return
            }
            XCTAssertNotNil(error)
        }
        
        
        expectation.fulfill()
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testUserFailedIfReceiveNoDataNoResponseNoError(){
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolStub.self]
        let session = URLSession(configuration: configuration)
        let sub = UserNetwork(session: session)
        
        let expectation = expectation(description: "wait for request")
        
        URLProtocolStub.stub(data: nil, response:nil , error: nil )
        sub.getUser { resultat in
            guard case .failure(let error) = resultat else {
                XCTFail("TestReceiveNodata fail")
                
                return
            }
            XCTAssertNil(error)
          
            
        }
        expectation.fulfill()
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testUserIsCorrectWhenCorrectData(){
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolStub.self]
        let session = URLSession(configuration: configuration)
        let sub = UserNetwork(session: session)
        
        let expectation = expectation(description: "wait for request")
        
        URLProtocolStub.stub(data: ResponseDataFake.userCorrectData, response: nil, error: nil)
        sub.getUser { resultat in
            switch resultat {
            case.failure(let error):
                XCTFail("error noData")
                XCTAssertNotNil(error)
            case.success(let data):
                XCTAssertEqual(data.results[0].name.first, "Isabel")
            }
        }
        expectation.fulfill()
        wait(for: [expectation], timeout: 1.0)
    }
}
