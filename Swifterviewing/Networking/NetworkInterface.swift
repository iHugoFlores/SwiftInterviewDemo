//
//  NetworkInterface.swift
//  Swifterviewing
//
//  Created by Hugo Flores Perez on 7/23/20.
//  Copyright © 2020 World Wide Technology Application Services. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case serverError(Error)
    case noData
    case invalidData(Error)
    case invalidImageURL
}

protocol NetworkInterface {
    typealias CompletionHandler<T> = (Result<T, NetworkError>) -> ()
    func getDecodable<T: Decodable>(url: String, callback: @escaping CompletionHandler<T>)
    func getData(url: String, callback: @escaping CompletionHandler<Data>)
}
