//
//  HistoryView.swift
//  Feature
//
//  Created by 서원지 on 4/6/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import SwiftUI
import DesignSystem
import ComposableArchitecture
import Model

public struct HistoryView: View {
    @Bindable var store: StoreOf<HistoryFeature>
    var viewModel: HomeRepository = HomeRepository()
    @State var hasNext: Bool = false
    public init(
        store: StoreOf<HistoryFeature>
    ) {
        self.store = store
    }
    
    public var body: some View {
        VStack {
            Spacer()
                .frame(height: 16)
            
            HStack {
                Spacer()
                
                Text("나의 글")
                    .pretendardFont(family: .SemiBold, size: 18)
                    .foregroundColor(Color.basicBlack)
                
               
                
                Spacer()
            }
            .padding(.horizontal, 20)
            
            Spacer()
                .frame(height: 12)
            
            HStack {
                RoundedRectangle(cornerRadius: 100)
                    .fill(!hasNext ? Color.blue50 : Color.gray50)
                    .frame(width: 60, height: 34)
                    .overlay {
                        Text("진행")
                            .foregroundStyle(!hasNext ? Color.blue900 : Color.gray500)
                    }
                    .onTapGesture {
                        hasNext.toggle()
                    }
                
                Spacer()
                    .frame(width: 8)
                
                RoundedRectangle(cornerRadius: 100)
                    .fill(!hasNext ? Color.blue50 : Color.gray50)
                    .frame(width: 60, height: 34)
                    .overlay {
                        Text("종료")
                            .foregroundStyle(!hasNext ? Color.blue900 : Color.gray500)
                    }
                    .onTapGesture {
                        hasNext.toggle()
                    }
                
                Spacer()
                
                if let datacount = viewModel.pollMyModel?.data?.count {
                    Text("게시글: \(datacount)")
                        .pretendardFont(family: .SemiBold, size: 16)
                        .foregroundColor(Color.basicBlack)
                }
            }
            .padding(.horizontal, 20)
            
            Spacer()
                .frame(height: 31)
            
            
            ScrollView {
                VStack(spacing: 14) {
                    if let polls = viewModel.pollMyModel?.data {
                        ForEach(polls) { poll in
                            if poll.type! == "QUICK_POLL" {
                                quickPoll(poll)
                            } else {
                                storyPoll(poll)
                            }
                        }
                    }
                }
                .padding(20)
            }
            
            
        }
        .task {
            await viewModel.requestpollMy()
        }
    }
}

fileprivate extension HistoryView {
    
    @ViewBuilder
    private func quickPoll(_ poll: PollMyResponseModel) -> some View {
        let category = PollCategory(rawValue: poll.category!)!
        
        return VStack(spacing: 16) {
            HStack(spacing: 7) {
                Image(asset: makeImage(category))
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
                
                VStack(spacing: 12) {
                    Text(poll.vote1!)
                        .font(.headline5_SemiBold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .background(Color.blue50)
                        .clipShape(RoundedRectangle(cornerRadius: 7))
                    
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
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .background(Color.gray10)
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }
    
    @ViewBuilder
    private func storyPoll(_ poll: PollMyResponseModel) -> some View {
        let category = PollCategory(rawValue: poll.category!)!
        
        return VStack(spacing: 16) {
            VStack(spacing: 11) {
                HStack(spacing: 7) {
                    Image(asset: makeImage(category))
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
                
                Text(poll.title!)
                    .font(.headline5_SemiBold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(Color.black)
                
                Text(poll.content!)
                    .font(.body3_Regular)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .foregroundStyle(Color.black)
            }
            
            HStack {
                Spacer()
//                Text("\(minutesFromNow(to: poll.createdDate!)!)분 전")
//                    .foregroundStyle(Color.gray500)
            }
            .foregroundStyle(Color.gray500)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .background(Color.gray10)
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }
    
    private func makeImage(_ poll: PollCategory) -> ImageAsset {
        switch poll {
        case .all:
            .category_all
        case .politics:
            .category_politics
        case .region:
            .category_region
        case .economy:
            .category_economy
        case .generation:
            .category_generation
        case .relationships:
            .category_love
        case .gender:
            .category_gender
        case .etc:
            .category_etc
        }
    }
    
    private func minutesFromNow(to dateString: String) -> Int? {
        // DateFormatter 인스턴스 생성
        let dateFormatter = DateFormatter()
        // 포맷 설정
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        dateFormatter.timeZone = TimeZone.current // 현재 시간대 설정

        // 문자열을 Date 객체로 변환
        guard let date = dateFormatter.date(from: dateString) else {
            print("날짜 변환 실패")
            return nil
        }

        // 현재 날짜와 비교
        let now = Date()
        let difference = Calendar.current.dateComponents([.minute], from: date, to: now)

        return difference.minute
    }
}
