//
//  API.swift
//  Swifterviewing
//
//  Created by Tyler Thompson on 7/9/20.
//  Copyright © 2020 World Wide Technology Application Services. All rights reserved.
//

import Foundation

class API {
    private let imageCache = NSCache<NSString, NSData>()

    typealias Completion<T> = (Result<T, NetworkError>) -> ()
    
    private func areThereErrors<T>(data: Data?, response: URLResponse?, error: Error?, callback: Completion<T>) -> Data? {
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
}

extension API: NetworkInterface {
    func getDecodable<T>(url: String, callback: @escaping CompletionHandler<T>) where T : Decodable {
        guard let urlObj = URL(string: url) else { fatalError() }
        URLSession.shared.dataTask(with: urlObj) { [weak self] (data, response, error) in
            guard let data = self?.areThereErrors(data: data, response: response, error: error, callback: callback) else { return }
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                callback(.success(decodedData))
            } catch(let error) {
                callback(.failure(.invalidData(error)))
            }
        }.resume()
    }
    
    func getData(url: String, callback: @escaping CompletionHandler<Data>) {
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
