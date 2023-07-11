//
//  ComparableView.swift
//  BucketList
//
//  Created by Fauzan Dwi Prasetyo on 11/07/23.
//

import SwiftUI

struct User: Identifiable, Comparable {
    let id = UUID()
    let firstName: String
    let lastName: String
    
    static func < (lhs: User, rhs: User) -> Bool {
        lhs.lastName < rhs.lastName
    }
}

struct ComparableView: View {
    let users = [
        User(firstName: "Arnold", lastName: "Rimmer"),
        User(firstName: "Kristine", lastName: "Kochanski"),
        User(firstName: "David", lastName: "Lister"),
    ].sorted()
    
    // before
//        .sorted {
//            $0.lastName < $1.lastName
//        }
    
    var body: some View {
        List(users) {
            Text("\($0.firstName) \($0.lastName)")
        }
    }
}

struct ComparableView_Previews: PreviewProvider {
    static var previews: some View {
        ComparableView()
    }
}
