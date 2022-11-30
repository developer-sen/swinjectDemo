//
//  NetworkingTests.swift
//  SwinjectDemoTests
//
//  Created by SANJU MADUWANTHA on 2022-11-08.
//

import XCTest
import Swinject
import SwinjectAutoregistration

@testable import SwinjectDemo

class NetworkingTests: XCTestCase {
    
    // Dependancy injection container
    private let container = Container()
    
    override func setUp() {
        super.setUp()
        // Auto register MockNetworkClient
        container.autoregister(NetworkingClient.self,
                               argument: String.self,
                               initializer: MockNetworkClient.init)
        /*
         Register UserFetcher with ResponceOne.json,
         we have given this a name - Register_One
         */
        container.register(UserFetcher.self, name: "Register_One") { resolver in
            let client = resolver ~> (NetworkingClient.self, argument: "ResponceOne")
            return UserFetcher(networkClient: client)
        }
        /*
         Register UserFetcher with ResponceTwo.json,
         we have given this a name - Register_Two
         */
        container.register(UserFetcher.self, name: "Register_Two") { resolver in
            let client = resolver ~> (NetworkingClient.self, argument: "ResponseTwo")
            return UserFetcher(networkClient: client)
        }
    }
    
    override func tearDown() {
      super.tearDown()
      // Remove all registers from container
      container.removeAll()
    }
    
    func testUsersResponseOne() {
        // Resove UserFetcher with resolver named 'Register_One'
        let fetcher = container ~> (UserFetcher.self, name: "Register_One")
        let expectation = XCTestExpectation(description: "Fetch users list from ResponceOne.json")
            
        fetcher.fetch { response in
            XCTAssertEqual(123, response![0].id)
          expectation.fulfill()
        }
        // Since network requests are async, add a deley
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testUsersResponseTwo() {
        // Resove UserFetcher with resolver named 'Register_Two'
        let fetcher = container ~> (UserFetcher.self, name: "Register_Two")
        let expectation = XCTestExpectation(description: "Fetch users list from ResponceTwo.json")
            
        fetcher.fetch { response in
            XCTAssertEqual(333, response![0].id)
          expectation.fulfill()
        }
        // Since network requests are async, add a deley
        wait(for: [expectation], timeout: 1.0)
    }
}
