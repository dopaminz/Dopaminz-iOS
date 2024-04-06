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
    
    // MARK: - Properties
    
    var viewModel: HomeRepository = HomeRepository()
    @State private var didAppear = false
    
    
    // MARK: - Initializers
    
    public init( ) { }
    
    
    // MARK: - Views
    
    public var body: some View {
        VStack {
            navigationBar()
                .frame(height: 56)
            
            ScrollView {
                VStack(spacing: 14) {
                    ForEach(viewModel.polls) { poll in
                        if poll.type! == "QUICK_POLL" {
                            QuickPollView(poll: poll)
                        } else {
                            StoryPollView(poll: poll)
                        }
                    }
                    
                    GeometryReader { geometry in
                        Color.clear.preference(key: ScrollViewOffsetPreferenceKey.self, value: geometry.frame(in: .global).minY)
                    }
                    .frame(height: 0)
                    
                    ProgressView()
                        .padding()
                        .opacity(viewModel.isLoading ? 1.0 : 0)
                }
                .padding(20)
            }
            .onPreferenceChange(ScrollViewOffsetPreferenceKey.self) { value in
                if value < 1 { // 'value'가 1 미만일 때 스크롤 뷰의 끝에 도달했다고 간주
                    requestPolls()
                }
            }
        }
        .onAppear {
            if !didAppear {
                requestPolls()
                didAppear = true
            }
        }
    }
    
    private func navigationBar() -> some View {
        HStack {
            Image(asset: .logo_horizontal)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 22)
            
            Spacer()
            
            Button {
                // navigate to notification
            } label: {
                Image(asset: .bell)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundStyle(Color.gray800)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 20)
    }
}


// MARK: - Methods

extension HomeView {
    private func requestPolls() {
        Task {
            await viewModel.requestPoll(categories: [.economy, .etc], hot: false, createdDate: .ascending)
        }
    }
}

struct ScrollViewOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}
