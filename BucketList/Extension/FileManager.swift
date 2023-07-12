//
//  FileManager.swift
//  BucketList
//
//  Created by Fauzan Dwi Prasetyo on 13/07/23.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
