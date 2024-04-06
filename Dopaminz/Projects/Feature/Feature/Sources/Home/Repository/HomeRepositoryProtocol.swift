//
//  HomeRepositoryProtocol.swift
//  Feature
//
//  Created by 서원지 on 4/6/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import Foundation
import Model

public protocol HomeRepositoryProtocol {
    func requestPoll(page: Int, categories: [PollCategory], hot: Bool, createdDate: SortType) async
    func requestPollDetail(id: Int) async
    func requestPollDelete(id: Int) async
    func requestpollMy() async
    func requestVote(pollId: Int, voteNumber: Int) async
    func createPoll(type: PollType,
                    title: String,
                    content: String,
                    endDate: Date,
                    vote1: String,
                    vote2: String,
                    category: PollCategory) async
    
    func createComment(pollId: Int, content: String) async
}
