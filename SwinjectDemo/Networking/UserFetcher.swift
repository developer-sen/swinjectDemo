//
//  UserFetcher.swift
//  SwinjectDemo
//
//  Created by SANJU MADUWANTHA on 2022-11-07.
//

import Foundation

protocol Fetcher {
  func fetch(response: @escaping ([User]?) -> Void)
}

struct UserFetcher: Fetcher {
     
  let networkClient: NetworkingClient

  // Initialize with a NetworkClient
  init(networkClient: NetworkingClient) {
    self.networkClient = networkClient
  }

  // Return successfull response
  func fetch(response: @escaping ([User]?) -> Void) {
      networkClient.request(from: .Users) { data, error in
      // Log errors
      if let error = error {
        print("Error \(error.localizedDescription)")
        response(nil)
      }
      // Parse data into a list of User type.
      let decoded = self.decodeJSON(type: [User].self, from: data)
      response(decoded)
    }
  }

  // Decode JSON helper function with generic type.
  private func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
    let decoder = JSONDecoder()
    guard let data = from,
          let response = try? decoder.decode(type.self, from: data) else { return nil }

    return response
  }
}
