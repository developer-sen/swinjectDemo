//
//  SwinjectDemoTests.swift
//  SwinjectDemoTests
//
//  Created by SANJU MADUWANTHA on 2022-11-07.
//

import XCTest
import Swinject

// Import your app target, so your domain models are available in tests scope.
@testable import SwinjectDemo

class SwinjectDemoTests: XCTestCase {
    
    // Dependancy injection container
    private let container = Container()
    
    override func setUp() {
        super.setUp()
        // Register User
        container.register(User.self) { (resolver: Resolver, id: Int, name: String) in
            return User(id: id, name: name)
        }
        // Register list of User objects
        container.register([User].self) { resolver in
            let user1 = resolver.resolve(User.self, arguments: 123, "Sanju Dev")!
            let user2 = resolver.resolve(User.self, arguments: 234, "Dev Sanju")!
            return [user1, user2]
        }
    }
    
    override func tearDown() {
      super.tearDown()
        // Remove all registers from container
      container.removeAll()
    }
    
    func testUsersResponse() {
        let response = container.resolve([User].self)!
        XCTAssertEqual(response[0].id, 123)
    }
}
