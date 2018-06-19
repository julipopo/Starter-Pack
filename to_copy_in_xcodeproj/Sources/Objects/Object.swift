//
//  Object.swift
//  init_project
//
//  Created by julien on 18/06/2018.
//  Copyright © 2018 juliensimmer. All rights reserved.
//

import Foundation

// Todo - replace
struct Message: Codable {
    var status: Int
    var subject: String
    var userId: Int

    enum CodingKeys: String, CodingKey {
        case status
        case subject
        case userId = "user_id"
    }
}
