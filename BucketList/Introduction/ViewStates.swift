//
//  ViewStates.swift
//  BucketList
//
//  Created by Fauzan Dwi Prasetyo on 11/07/23.
//

import SwiftUI

enum LoadingState {
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
    let loadingState = LoadingState.loading
    
    var body: some View {
        switch loadingState {
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
