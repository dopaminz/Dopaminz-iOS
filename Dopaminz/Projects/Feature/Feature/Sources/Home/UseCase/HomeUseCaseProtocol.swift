//
//  HomeUseCaseProtocol.swift
//  Feature
//
//  Created by 서원지 on 4/6/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import Foundation
import Model

public protocol HomeUseCaseProtocol {
    func requestPoll(page: Int, categories: [PollCategory], hot: Bool, createdDate: SortType) async
    func requestPollDetail(id: Int) async
    func requestPollDelete(id: Int) async
}
