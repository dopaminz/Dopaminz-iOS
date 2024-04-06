//
//  PollCategory.swift
//  Model
//
//  Created by 이승기 on 4/6/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import Foundation

public enum PollCategory: String, Codable, Equatable, CaseIterable {
    case all = "ALL"
    case politics = "POLITICS"
    case region = "REGION"
    case economy = "ECONOMY"
    case generation = "GENERATION"
    case relationships = "RELATIONSHIPS"
    case gender = "GENDER"
    case etc = "ETC"
    
    public var desc: String {
        switch self {
        case .all:
            return "전체"
        case .politics:
            return "정치"
        case .region:
            return "지역"
        case .economy:
            return "경제"
        case .generation:
            return "세대"
        case .relationships:
            return "연애"
        case .gender:
            return "성별"
        case .etc:
            return "기타"
        }
    }
}
