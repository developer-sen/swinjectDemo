//
//  Endpoint.swift
//  SwinjectDemo
//
//  Created by SANJU MADUWANTHA on 2022-11-07.
//

import Foundation

enum Endpoint {
    case Users
}

extension Endpoint {
    func getUrl() -> String {
        switch self {
        case .Users:
            return "https://jsonplaceholder.typicode.com/users"
        }
    }
}
