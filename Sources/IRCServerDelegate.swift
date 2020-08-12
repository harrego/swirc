//
//  IRCServerDelegate.swift
//  IRC
//
//  Created by Harry Stanton on 3/1/20.
//

import Foundation

public protocol IRCServerDelegate: class {
  
  func ircConnected(server: IRCServer)
  func ircDisconnected(server: IRCServer)
  func ircEvent(server: IRCServer, joined channel: String)
  func ircEvent(server: IRCServer, left channel: String)
  func ircEvent(server: IRCServer, user: IRCUser, joined channel: String)
  func ircEvent(server: IRCServer, user: IRCUser, left channel: String)
  func ircEvent(server: IRCServer, rawMessage: IRCMessage)
  
}
