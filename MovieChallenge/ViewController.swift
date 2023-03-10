//
//  ViewController.swift
//  MovieChallenge
//
//  Created by Tatiana Carvajal on 8/03/23.
//

import UIKit

class ViewController: UIViewController {

    var service: ServiceProtocol = ServiceFacade()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMovies()
    }
    
    private func loadMovies() {
        service.fetchTopRatedMovies { result in
            switch result {
            case .success(let topRatedResponse):
                print(topRatedResponse)
            case .failure(let error): print(error)
            }
        }
    }


}
