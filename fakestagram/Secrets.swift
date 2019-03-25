//
//  Secrets.swift
//  fakestagram
//
//  Created by LuisE on 3/17/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import Foundation

enum Secrets {
    case uuid
    
    var value: String? {
        switch self {
        case .uuid:
            return nil
        }
    }
}
