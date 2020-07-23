//
//  Album.swift
//  Swifterviewing
//
//  Created by Tyler Thompson on 7/9/20.
//  Copyright © 2020 World Wide Technology Application Services. All rights reserved.
//

import Foundation

struct Album: Decodable {
    let title: String
    let thumbnailUrl: String
    
    lazy var titleWithNoE = self.title.replacingOccurrences(of: "e", with: "", options: .caseInsensitive)
}
