//
//  DetailView.swift
//  Feature
//
//  Created by 이승기 on 4/7/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import SwiftUI
import Model
import DesignSystem

struct DetailView: View {
    
    // MARK: - Properties
  
    var viewModel: HomeRepository = HomeRepository()
    
    private let poll: Content
    private var category: PollCategory!
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var selectedVote = 0
    
    @State private var isVoted = false
    @State private var voteCount1 = 0
    @State private var voteCount2 = 0
  
    @State private var votedNumber: Int = 0
    
    
    // MARK: - Initializers
    
    public init(poll: Content) {
        self.poll = poll
        self.category = PollCategory(rawValue: poll.category!)!
        self.isVoted = poll.isVoted!
        self.voteCount1 = poll.vote1Count!
        self.voteCount2 = poll.vote2Count!
    }
    
    
    // MARK: - Views
    
    var body: some View {
        ZStack {
            VStack {
                NavigationTitleButton(title: "사연 법정") {
                    dismiss()
                }
                
                if let pollDetail = viewModel.pollDetailModel {
                    ScrollView {
                        VStack(spacing: 0) {
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
                            .padding(.top, 10)
                            
                            Text(poll.title!)
                                .font(.headline5_SemiBold)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundStyle(Color.black)
                                .padding(.top, 10)
                            
                            Text(poll.content!)
                                .font(.body2_Regular)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .multilineTextAlignment(.leading)
                                .foregroundStyle(Color.black)
                                .padding(.top, 18)
                            
                            if let pollDetailModel = viewModel.pollDetailModel {
                                pollView()
                                    .padding(.top, 40)
                                    .padding(.bottom, 25)
                            } else {
                                ProgressView()
                            }
                            
                            Rectangle()
                                .fill(Color.gray50)
                                .frame(height: 6)
                                .padding(.horizontal, -20)
                            
                          if let pollDetailModel = viewModel.pollDetailModel {
                            commentView(comments: pollDetail.data?.comments ?? [])
                          } else {
                            ProgressView()
                              .padding()
                          }
                        }
                        .padding(20)
                    }
                } else {
                    VStack {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                }
                
                
            }
            .background(Color.white.ignoresSafeArea())
            .toolbar(.hidden, for: .navigationBar)
            
            VStack(spacing: 0) {
                Spacer()
                
                HStack(spacing: 11) {
                    Capsule()
                        .fill(Color.gray50)
                        .frame(height: 40)
                        .overlay {
                            Text("댓글이 비활성화 되었습니다.")
                                .font(.body3_Medium)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundStyle(Color.gray400)
                                .padding(.horizontal, 13)
                        }
                    
                    Text("등록")
                        .font(.body3_Medium)
                        .foregroundStyle(Color.black)
                        .opacity(0.5)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 4)
                .background(Color.white.ignoresSafeArea())
            }
        }
        .task {
            await viewModel.requestpollMy()
            await viewModel.requestPollDetail(id: poll.id)
        }
    }
    
    private func pollView() -> some View {
        VStack(spacing: 16) {
            Text("투표")
                .font(.headline5_SemiBold)
                .foregroundStyle(Color.black)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            if viewModel.pollDetailModel!.data!.isVoted ?? false || isVoted {
                pollPendingView(poll: poll)
            } else {
                selectablePollView()
            }
        }
        .padding(20)
        .background(Color.gray10)
        .frame(maxWidth: .infinity)
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }
    
    private func selectablePollView() -> some View {
        VStack(spacing: 12) {
            Button {
                selectedVote = 1
            } label: {
                Text("A. \(poll.vote1!)")
                    .font(.pretendardFontFamily(family: .Regular, size: 16))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .background(selectedVote == 1 ? Color.blue100 : Color.blue50)
                    .clipShape(RoundedRectangle(cornerRadius: 7))
                    .overlay {
                        if selectedVote == 1 {
                            RoundedRectangle(cornerRadius: 7)
                                .stroke(Color.blue300)
                        }
                    }
            }
            
            Button {
                selectedVote = 2
            } label: {
                Text("B. \(poll.vote2!)")
                    .font(.pretendardFontFamily(family: .Regular, size: 16))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .background(selectedVote == 2 ? Color.blue100 : Color.blue50)
                    .clipShape(RoundedRectangle(cornerRadius: 7))
                    .overlay {
                        if selectedVote == 2 {
                            RoundedRectangle(cornerRadius: 7)
                                .stroke(Color.blue300)
                        }
                    }
            }
            
            CustomButton(isDisabled: .constant(selectedVote == 0), title: "투표하기") {
                Task {
                    if selectedVote == 1 {
                        voteCount1 += 1
                    } else {
                        voteCount2 += 1
                    }
                    
                    isVoted = true
                    votedNumber = selectedVote
                    await viewModel.requestVote(pollId: poll.id, voteNumber: selectedVote)
                }
            }
            .frame(maxWidth: .infinity, minHeight: 44)
        }
    }
    
    private func pollPendingView(poll: Content) -> some View {
        VStack(spacing: 12) {
            Text(poll.vote1!)
                .font(.pretendardFontFamily(family: .Regular, size: 16))
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
                .font(.pretendardFontFamily(family: .Regular, size: 16))
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
            
            CustomButton(isDisabled: .constant(true), title: "수정하기") { }
                .frame(height: 44)
        }
    }
    
    private func pollResultView(poll: Content) -> some View {
        VStack(spacing: 12) {
            let isEmpty = poll.vote1Count! + poll.vote2Count! == 0
            pollProgressView(title: poll.vote1!, percent: isEmpty ? 0 : Int(voteCount1 / (voteCount1 + voteCount2) * 100))
            pollProgressView(title: poll.vote2!, percent: isEmpty ? 0 : Int(voteCount2 / (voteCount1 + voteCount2) * 100))
        }
    }
    
    private func pollProgressView(title: String, percent: Int) -> some View {
        ZStack {
            Color.blue50
            
            GeometryReader { geometry in
                Color.blue300
                    .frame(width: geometry.size.width * CGFloat(percent) / 100)
            }
            
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
        }
        .clipShape(RoundedRectangle(cornerRadius: 7))
    }
  
  private func commentView(comments: [Comment]) -> some View {
    VStack {
      HStack {
        Text("댓글 \(comments.count)")
          .font(.body2_Regular)
          .foregroundStyle(Color.gray500)
        Spacer()
      }
      .padding(.top, 20)
      .padding(.bottom, 8)
      
      ForEach(comments, id: \.self) { comment in
        VStack(spacing: 8) {
          Text(comment.nickname)
            .font(.body_Medium)
            .frame(maxWidth: .infinity, alignment: .leading)
          
          Text(comment.content)
            .font(.body3_Regular)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 14)
      }
    }
    .padding(.bottom, 100)
  }
}
