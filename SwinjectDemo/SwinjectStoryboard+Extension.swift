//
//  SwinjectStoryboard+Extension.swift
//  SwinjectDemo
//
//  Created by SANJU MADUWANTHA on 2022-11-09.
//

import Swinject
import SwinjectStoryboard
import SwinjectAutoregistration

extension SwinjectStoryboard {
    @objc class func setup() {
        /*
         This uses autoregister so whenever NetworkingClient is required,
         it will resolve a HTTPClient.
         Same with Fetcher and UserFetcher.
         */
        defaultContainer.autoregister(NetworkingClient.self, initializer: HTTPClient.init)
        defaultContainer.autoregister(Fetcher.self, initializer: UserFetcher.init)
        // This block is executed before ViewController is displayed and resolves required dependencies
        defaultContainer.storyboardInitCompleted(ViewController.self) { resolver, controller in
            controller.fetcher = resolver ~> UserFetcher.self
        }
    }
}
