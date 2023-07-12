//
//  ViewStates.swift
//  BucketList
//
//  Created by Fauzan Dwi Prasetyo on 11/07/23.
//

import SwiftUI

enum LoadingStateIntro {
    case loading, success, failed
}

struct LoadingView: View {
    var body: some View {
        Text("Loading...")
    }
}

struct SuccessView: View {
    var body: some View {
        Text("Success!")
    }
}

struct FailedView: View {
    var body: some View {
        Text("Failed.")
    }
}

struct ViewStates: View {
    let loadingStateIntro = LoadingStateIntro.loading
    
    var body: some View {
        switch loadingStateIntro {
        case .loading:
            LoadingView()
        case .success:
            SuccessView()
        case .failed:
            FailedView()
        }
    }
}

struct ViewStates_Previews: PreviewProvider {
    static var previews: some View {
        ViewStates()
    }
}
