//
//  MockNetworkClient.swift
//  SwinjectDemoTests
//
//  Created by SANJU MADUWANTHA on 2022-11-08.
//

import XCTest
import Foundation

@testable import SwinjectDemo

struct MockNetworkClient: NetworkingClient {
  let mockResponseJSONfile: String
  
  func request(from: Endpoint, completion: @escaping CompletionHandler) {
    let data = readJSON(name: mockResponseJSONfile)
    completion(data, nil)
  }
  
  private func readJSON(name: String) -> Data? {
    let bundle = Bundle(for: NetworkingTests.self)
    guard let url = bundle.url(forResource: name, withExtension: "json") else { return nil }
    
    do {
      return try Data(contentsOf: url, options: .mappedIfSafe)
    }
    catch {
      XCTFail("Parsing test data failed")
      return nil
    }
  }
}
