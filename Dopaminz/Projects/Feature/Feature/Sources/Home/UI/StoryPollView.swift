//
//  StoryPollView.swift
//  Feature
//
//  Created by 이승기 on 4/7/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import SwiftUI
import DesignSystem
import Model

struct StoryPollView: View {
    
    // MARK: - Properties
    
    private let poll: Content
    private var category: PollCategory!
    
    
    // MARK: - Initializers
    
    public init(poll: Content) {
        self.poll = poll
        self.category = PollCategory(rawValue: poll.category!)!
    }
    
    
    // MARK: - Views
    
    var body: some View {
        VStack(spacing: 16) {
            VStack(spacing: 11) {
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
                
                Text(poll.title!)
                    .font(.headline5_SemiBold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(Color.black)
                
                Text(poll.content!)
                    .font(.body3_Regular)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .foregroundStyle(Color.black)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .background(Color.gray10)
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }
}
