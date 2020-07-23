//
//  API.swift
//  Swifterviewing
//
//  Created by Tyler Thompson on 7/9/20.
//  Copyright © 2020 World Wide Technology Application Services. All rights reserved.
//

import Foundation

class API {
    private let baseURL = "https://jsonplaceholder.typicode.com"
    private let photosEndpoint = "/photos" //returns photos and their album ID
    //private let albumsEndpoint = "/albums" //returns an album, but without photos
    
    private let imageCache = NSCache<NSString, NSData>()
    
    typealias CompletionHandler<T> = (Result<T, AlbumError>) -> ()
    
    private func areThereErrors<T>(data: Data?, response: URLResponse?, error: Error?, callback: CompletionHandler<T>) -> Data? {
        if let error = error {
            callback(.failure(.serverError(error)))
            return nil
        }
        guard let data = data else {
            callback(.failure(.noData))
            return nil
        }
        return data
    }
    
    func getAlbums(callback: @escaping CompletionHandler<[Album]>) {
        guard let url = URL(string: "\(baseURL)\(photosEndpoint)") else { fatalError() }
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let data = self?.areThereErrors(data: data, response: response, error: error, callback: callback) else { return }
            do {
                let decodedData = try JSONDecoder().decode([Album].self, from: data)
                callback(.success(decodedData))
            } catch(let error) {
                callback(.failure(.invalidData(error)))
            }
        }.resume()
    }
    
    func getAlbumImage(url: String, callback: @escaping CompletionHandler<Data>) {
        if let cachedData = imageCache.object(forKey: url as NSString) {
            callback(.success(cachedData as Data))
        }
        guard let urlObj = URL(string: url) else {
            callback(.failure(.invalidImageURL))
            return
        }
        URLSession.shared.dataTask(with: urlObj) { [weak self] (data, response, error) in
            guard let data = self?.areThereErrors(data: data, response: response, error: error, callback: callback) else { return }
            callback(.success(data))
            self?.imageCache.setObject(data as NSData, forKey: url as NSString)
        }.resume()
    }
}

extension API {
    enum AlbumError: Error {
        case serverError(Error)
        case noData
        case invalidData(Error)
        case invalidImageURL
    }
}
