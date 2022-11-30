//
//  HTTPClient.swift
//  SwinjectDemo
//
//  Created by SANJU MADUWANTHA on 2022-11-07.
//

import Foundation

// Protocol has one request function and and completion block to return Data or Error
protocol NetworkingClient {
  typealias CompletionHandler = (Data?, Swift.Error?) -> Void
  
  func request(from: Endpoint, completion: @escaping CompletionHandler)
}

// Concrete implementation of NetworkingClient
struct HTTPClient: NetworkingClient {
  // Execute HTTP request and returning its result via the provided CompletionHandler
  func request(from: Endpoint, completion: @escaping CompletionHandler) {
    guard let url = URL(string: from.getUrl()) else { return }
    let request = createRequest(from: url)
    let task = createDataTask(from: request, completion: completion)
    task.resume()
  }
  
  // Takes a URL and returns a URLRequest
  private func createRequest(from url: URL) -> URLRequest {
    var request = URLRequest(url: url)
    request.cachePolicy = .reloadIgnoringCacheData
    return request
  }
  
  // Takes a URLRequest and returns a URLSessionDataTask
  private func createDataTask(from request: URLRequest,
                              completion: @escaping CompletionHandler) -> URLSessionDataTask {
    return URLSession.shared.dataTask(with: request) { data, httpResponse, error in
      completion(data, error)
    }
  }
}
