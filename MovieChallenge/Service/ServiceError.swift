//
//  ServiceError.swift
//  MovieChallenge
//
//  Created by Tatiana Carvajal on 8/03/23.
//

import Foundation

enum ServiceError: Error {
    case urlDoesNotExist
    case noDataFound
    case serializationFailed
}
