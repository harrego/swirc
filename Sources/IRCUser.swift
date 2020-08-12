//
//  IRCUser.swift
//  IRC iOS
//
//  Created by Harry Stanton on 2/29/20.
//

import Foundation

public struct IRCUser {
  public let nick: String
  public let username: String
  public let realname: String
  
  public init(nick: String, username: String, realname: String) {
    self.nick = nick
    self.username = username
    self.realname = realname
  }
}
