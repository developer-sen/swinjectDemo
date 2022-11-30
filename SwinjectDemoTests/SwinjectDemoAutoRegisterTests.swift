//
//  SwinjectDemoAutoRegisterTests.swift
//  SwinjectDemoTests
//
//  Created by SANJU MADUWANTHA on 2022-11-07.
//

import XCTest
import Swinject
import SwinjectAutoregistration

// Import your app target, so your domain models are available in tests scope.
@testable import SwinjectDemo

class SwinjectDemoAutoRegisterTests: XCTestCase {
    
    // Dependancy injection container
    private let container = Container()
    
    override func setUp() {
        super.setUp()
        // Auto register User
        container.autoregister(User.self,
                               arguments: Int.self, String.self,
                               initializer: User.init(id:name:))
    }
    
    override func tearDown() {
      super.tearDown()
        // Remove all registers from container
      container.removeAll()
    }
    
    func testUsersResponse() {
        // reduced code with autoregister
        let user = container ~> (User.self, arguments: (123, "Sanju Dev"))
        XCTAssertEqual(user.id, 123)
    }
}
