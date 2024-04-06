//
//  QuickPollView.swift
//  Feature
//
//  Created by 이승기 on 4/7/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import SwiftUI
import Model
import DesignSystem

struct QuickPollView: View {
    
    // MARK: - Properties
    
    private let poll: Content
    private var category: PollCategory!
    var polid: Int
    @State private var isVoted = false
    var viewModel: HomeRepository = HomeRepository()
    
    @State private var selectedVote = 0
    @State private var voteCount1 = 0
    @State private var voteCount2 = 0
    @State private var votedNumber = 0
   
    
    // MARK: - Initializers
    
    public init(poll: Content, polid: Int) {
        self.poll = poll
        self.polid = polid
        self.category = PollCategory(rawValue: poll.category!)!
        isVoted = poll.isVoted!
        
        voteCount1 = poll.vote1Count ?? 0
        voteCount2 = poll.vote2Count ?? 0
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
                
                if let pollDetail = viewModel.pollDetailModel?.data {
                    if pollDetail.isVoted ?? false || isVoted {
                        pollResultView(poll: poll)
                    } else {
                        selectablePollView()
                    }
                } else {
                    ProgressView()
                        .padding()
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .background(Color.gray10)
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .task {
            await viewModel.requestPollDetail(id: poll.id)
        }
    }
    
    private func selectablePollView() -> some View {
        VStack(spacing: 12) {
            Button {
                Task {
                    await viewModel.requestVote(pollId: polid, voteNumber: 1)
                    selectedVote = 1
                    voteCount1 += 1
                    votedNumber = 1
                    isVoted = true
                }
            } label: {
                Text(poll.vote1!)
                    .font(.headline5_SemiBold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
                    .frame(height: 44)
                    .multilineTextAlignment(.leading)
                    .lineLimit(1)
                    .background(Color.blue50)
                    .clipShape(RoundedRectangle(cornerRadius: 7))
                    
            }
            
            Button {
                Task {
                    await viewModel.requestVote(pollId: polid, voteNumber: 2)
                    selectedVote = 2
                    voteCount2 += 1
                    votedNumber = 2
                    isVoted = true
                }
            } label: {
                Text(poll.vote2!)
                    .font(.headline5_SemiBold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
                    .frame(height: 44)
                    .multilineTextAlignment(.leading)
                    .lineLimit(1)
                    .background(Color.blue50)
                    .clipShape(RoundedRectangle(cornerRadius: 7))
                    
            }
        }
    }
    
    private func pollResultView(poll: Content) -> some View {
        VStack(spacing: 12) {
            let a = (0...100).randomElement()!
            let b = 100 - a
//            pollProgressView(title: poll.vote1!, percent: a)
//            pollProgressView(title: poll.vote2!, percent: b)
            PollProgressView(title: poll.vote1!, targetPercent: a)
                .frame(maxWidth: .infinity)
            
            PollProgressView(title: poll.vote2!, targetPercent: b)
                .frame(maxWidth: .infinity)
        }
    }
    
    private func pendingView(poll: Content) -> some View {
        VStack(spacing: 12) {
            Text(poll.vote1!)
                .font(.headline5_SemiBold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background {
                    if viewModel.pollDetailModel!.data!.votedNumber == 1 || votedNumber == 1 {
                        Color.blue100
                            .clipShape(RoundedRectangle(cornerRadius: 7))
                            .overlay {
                                RoundedRectangle(cornerRadius: 7)
                                    .stroke(Color.blue300)
                            }
                    } else {
                        Color.blue50
                            .clipShape(RoundedRectangle(cornerRadius: 7))
                    }
                }
            
            Text(poll.vote2!)
                .font(.headline5_SemiBold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background {
                    if viewModel.pollDetailModel!.data!.votedNumber == 2 || votedNumber == 2 {
                        Color.blue100
                            .clipShape(RoundedRectangle(cornerRadius: 7))
                            .overlay {
                                RoundedRectangle(cornerRadius: 7)
                                    .stroke(Color.blue300)
                            }
                    } else {
                        Color.blue50
                            .clipShape(RoundedRectangle(cornerRadius: 7))
                    }
                }
        }
    }
    

//    
//    private func pollProgressView(title: String, percent: Int) -> some View {
//        ZStack {
//            Color.blue50
//            
//            GeometryReader { geometry in
//                Color.blue300
//                    .frame(width: geometry.size.width * CGFloat(percent) / 100)
//                    .frame(height: 44)
//            }
//            
//            HStack {
//                Text(title)
//                    .font(.headline5_SemiBold)
//                    .foregroundStyle(Color.white)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .multilineTextAlignment(.leading)
//                    .lineLimit(1)
//                
//                Text("\(percent)%")
//                    .font(.headline5_SemiBold)
//                    .foregroundStyle(Color.blue500)
//            }
//            .padding(.horizontal, 16)
//            .frame(height: 44)
//        }
//        .frame(maxWidth: .infinity)
//        .clipShape(RoundedRectangle(cornerRadius: 7))
//        .frame(minHeight: 44, maxHeight: 44)
//    }
}

struct PollProgressView: View {
    let title: String
    let targetPercent: Int
    @State private var animatedPercent: CGFloat = 0 // 애니메이션을 위한 상태 변수

    var body: some View {
        ZStack(alignment: .leading) {
            Color.blue50

            // 프로그레스 바
            GeometryReader { proxy in
                Rectangle()
                    .fill(Color.blue300)
                    .frame(width: animatedPercent, height: 44) // 애니메이션 적용된 너비 사용
                    .onAppear {
                        withAnimation(.easeInOut(duration: 1.0)) {
                            animatedPercent = proxy.size.width * CGFloat(targetPercent) / 100
                        }
                    }
            }
            
            HStack {
                Text(title)
                    .font(.headline5_SemiBold)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.white)
                    .padding(.leading, 16)
                
                Spacer()
                
                Text("\(targetPercent)%")
                    .font(.headline5_SemiBold)
                    .foregroundColor(.blue500)
                    .padding(.trailing, 16)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 7))
        .frame(height: 44) // 높이를 44로 고정
    }
}
