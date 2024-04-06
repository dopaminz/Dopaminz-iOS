//
//  HomeView.swift
//  Feature
//
//  Created by 서원지 on 4/6/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import SwiftUI
import DesignSystem
import ComposableArchitecture
import Model

public struct HomeView: View {
    var viewModel: HomeRepository = HomeRepository()
    
    public init( ) { }
    
    public var body: some View {
        Text("")
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    Task {
                        await viewModel.requestPoll(page: 0, categories: [.economy, .etc], hot: false, createdDate: .ascending)
                    }
                }
            }
    }
}

