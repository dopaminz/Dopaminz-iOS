//
//  PollsAPI.swift
//  API
//
//  Created by 이승기 on 4/6/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import Foundation

public enum PollsAPI {
  public static let requestPolls: String = "/polls"
  public static let requestPoll: String = "/polls"
  public static let createPoll: String = "/polls"
  public static let deletePoll: String = "/polls/"
  public static let vote: String = "/votes"
  public static let revote: String = "/votes"
  public static let postComment: String = "/comments"
  public static let deleteComment: String = "/comments"
    public static let requestpollsMy: String = "/polls/my"
}
