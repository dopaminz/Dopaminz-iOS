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
    var authviewModel: AuthRepository = AuthRepository()
    @State private var didAppear = false
    @State var createPOLL: Bool = false
    
    // MARK: - Initializers
    
    public init( ) { }
    
    
    // MARK: - Views
    
    public var body: some View {
      NavigationView {
        VStack {
            navigationBar()
                .frame(height: 56)
            
            ScrollView {
                VStack(spacing: 14) {
                    ForEach(viewModel.pollModel?.data?.contents ?? []) { poll in
                        if poll.type! == "QUICK_POLL" {
                            QuickPollView(poll: poll, polid: 3)
                        } else {
                          NavigationLink {
                            DetailView(poll: poll)
                          } label: {
                            StoryPollView(poll: poll)
                          }
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
        .fullScreenCover(isPresented: $createPOLL, content: {
            CraatePollView()
        })
      }
        .onAppear {
            if !didAppear {
                requestPolls()
                didAppear = true
            }
            
        }
        .task {
            await authviewModel.requsetProfile(completion: {})
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
                createPOLL.toggle()
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
