//
//  Result.swift
//  BucketList
//
//  Created by Fauzan Dwi Prasetyo on 12/07/23.
//

import Foundation

struct Result: Codable {
    let query: Query
}

struct Query: Codable {
    let pages: [Int: Page]
}

struct Page: Codable {
    let pageid: Int
    let title: String
    let terms: [String: [String]]?
}
