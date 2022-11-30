//
//  ViewController.swift
//  SwinjectDemo
//
//  Created by SANJU MADUWANTHA on 2022-11-07.
//

import UIKit

class ViewController: UIViewController {
    
//    let fetcher = UserFetcher(networkClient: HTTPClient())
    var fetcher: Fetcher?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUsers()
    }
    
    private func fetchUsers()  {
        guard let fetcher = fetcher else { fatalError("Dependencies not injected") }
        fetcher.fetch { response in
           guard let response = response else { return }
            DispatchQueue.main.async { [weak self] in
              self?.updateUI(response: response)
            }
         }
    }
    
    private func updateUI(response: [User]) {
        // code related to updating UI goes here.
    }
}



