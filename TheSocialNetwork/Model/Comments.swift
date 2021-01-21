//
//  Comments.swift
//  TheSocialNetwork
//
//  Created by Muhammad Arslan Asim on 19.01.21.
//

import Foundation

struct Comment: Codable {
    
    let postId: Int
    let id: Int
    let name: String
    let email: String
    let body: String
}
