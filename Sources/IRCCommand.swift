//
//  IRCCommand.swift
//  IRC iOS
//
//  Created by Harry Stanton on 2/29/20.
//

import Foundation

public enum IRCCommand: String {
  
  // 3.1 Connection Registration
  case pass = "PASS"
  case nick = "NICK"
  case user = "USER"
  case oper = "OPER"
  case mode = "MODE"
  case service = "SERVICE"
  case quit = "QUIT"
  case squit = "SQUIT"
  
  // 3.2 Channel operations
  case join = "JOIN"
  case part = "PART"
  case topic = "TOPIC"
  case names = "NAMES"
  case list = "LIST"
  case invite = "INVITE"
  case kick = "KICK"
  
  // 3.3 Sending messages
  case privmsg = "PRIVMSG"
  case notice = "NOTICE"
  
  // 3.4 Server queries and commands
  case motd = "MOTD"
  case lusers = "LUSERS"
  case version = "VERSION"
  case stats = "STATS"
  case links = "LINKS"
  case time = "TIME"
  case connect = "CONNECT"
  case trace = "TRACE"
  case admin = "ADMIN"
  case info = "INFO"
  
  // 3.5 Service Query and Commands
  case servlist = "SERVLIST"
  case squery = "SQUERY"
  
  // 3.6 User based queries
  case who = "WHO"
  case whois = "WHOIS"
  case whowas = "WHOWAS"
  
  // 3.7 Miscellaneous messages
  case kill = "KILL"
  case ping = "PING"
  case pong = "PONG"
  case error = "ERROR"
  
  // 4. Optional features
  case away = "AWAY"
  case rehash = "REHASH"
  case die = "DIE"
  case restart = "RESTART"
  case summon = "SUMMON"
  case users = "USERS"
  case operwall = "WALLOPS"
  case userhost = "USERHOST"
  case ison = "ISON"
  
}
