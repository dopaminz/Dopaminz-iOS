//
//  QuickPollView.swift
//  Feature
//
//  Created by 이승기 on 4/7/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import SwiftUI
import Model

struct QuickPollView: View {
    
    // MARK: - Properties
    
    private let poll: Content
    private var category: PollCategory!
    var polid: Int
    @State private var isVoted = false
    var viewModel: HomeRepository = HomeRepository()
   
    
    // MARK: - Initializers
    
    public init(poll: Content, polid: Int) {
        self.poll = poll
        self.polid = polid
        self.category = PollCategory(rawValue: poll.category!)!
        isVoted = poll.isVoted!
    }
    
    
    // MARK: - Views
    
    var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 7) {
                Image(asset: category.imageAsset)
                    .resizable()
                    .frame(width: 34, height: 34)
                
                Text(category.desc)
                    .font(.body3_Medium)
                    .foregroundStyle(Color.black)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 4)
                    .background(Color.gray100)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                
                Spacer()
            }
            
            VStack(spacing: 23) {
                Text(poll.title!)
                    .font(.headline4)
                    .foregroundStyle(Color.black)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                
                if isVoted {
                    pollResultView(poll: poll)
                } else {
                    selectablePollView()
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .background(Color.gray10)
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }
    
    private func selectablePollView() -> some View {
        VStack(spacing: 12) {
            Button {
                Task {
                    await viewModel.requestVote(pollId: polid, voteNumber: 1)
                }
            } label: {
                Text(poll.vote1!)
                    .font(.headline5_SemiBold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .background(Color.blue50)
                    .clipShape(RoundedRectangle(cornerRadius: 7))
            }
            
            Button {
                Task {
                    await viewModel.requestVote(pollId: polid, voteNumber: 2)
                }
            } label: {
                Text(poll.vote2!)
                    .font(.headline5_SemiBold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .background(Color.blue50)
                    .clipShape(RoundedRectangle(cornerRadius: 7))
            }
        }
    }
    
    private func pollResultView(poll: Content) -> some View {
        VStack(spacing: 12) {
            let isEmpty = poll.vote1Count! + poll.vote2Count! == 0
            pollProgressView(title: poll.vote1!, percent: isEmpty ? 0 : Int(poll.vote1Count! / poll.vote1Count! + poll.vote2Count!))
            pollProgressView(title: poll.vote2!, percent: isEmpty ? 0 : Int(poll.vote2Count! / poll.vote1Count! + poll.vote2Count!))
        }
    }
    
    private func pollProgressView(title: String, percent: Int) -> some View {
        ZStack {
            Color.blue50
            
            HStack {
                Text(title)
                    .font(.headline5_SemiBold)
                    .foregroundStyle(Color.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("\(percent)%")
                    .font(.headline5_SemiBold)
                    .foregroundStyle(Color.blue500)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            
            GeometryReader { geometry in
                Color.blue300
                    .frame(width: geometry.size.width * CGFloat(percent) / 100)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 7))
    }
}
