//
//  IRCEvent.swift
//  IRC iOS
//
//  Created by Harry Stanton on 2/29/20.
//

import Foundation

public class IRCMessage {
  public let prefix: String?
  public let command: IRCCommand?
  public let numericResponse: IRCNumericResponse?
  public let parameters: String
  public let raw: String
  
  enum Error: Swift.Error {
    case invalidMessage
  }
  
  public init(prefix: String?, command: IRCCommand, parameters: String, raw: String) {
    self.prefix = prefix
    self.command = command
    self.numericResponse = nil
    self.parameters = parameters
    self.raw = raw
  }
  
  public init(prefix: String?, numericResponse: IRCNumericResponse?, parameters: String, raw: String) {
    self.prefix = prefix
    self.command = nil
    self.numericResponse = numericResponse
    self.parameters = parameters
    self.raw = raw
  }
  
  public init(parse raw: String) throws {
    self.raw = raw
    
    let parts = raw.components(separatedBy: " ")
    
    guard parts.count > 1 else {
      print("invalid msg: \(raw)")
      throw Error.invalidMessage
    }
    
    guard let firstChar = parts[0].first else {
      print("invalid msg: \(raw)")
      throw Error.invalidMessage
    }
    if firstChar == ":" {
      let fullPrefix = parts[0]
      let startIndex = fullPrefix.index(fullPrefix.startIndex, offsetBy: 1)
      self.prefix = String(fullPrefix[startIndex..<fullPrefix.endIndex])
    } else {
      self.prefix = nil
    }
    
    let strCommand = self.prefix == nil ? parts[0] : parts[1]
    let parsedCommand = IRCCommand(rawValue: strCommand)
    
    if let command = parsedCommand {
      self.command = command
      self.numericResponse = nil
    } else if strCommand.rangeOfCharacter(from: .decimalDigits) != nil {
      guard let numericResponse = IRCNumericResponse(rawValue: strCommand) else {
        print("invalid msg, bad numeric resp: \(raw)")
        throw Error.invalidMessage
      }
      self.numericResponse = numericResponse
      self.command = nil
    } else {
      print("invalid msg: \(raw)")
      throw Error.invalidMessage
    }
    
    let remaining = self.prefix != nil ? 2 : 1
    let splitParameters = parts[remaining...]
    let parametersStr = splitParameters.joined(separator: " ")
    if let parameterFirst = parametersStr.first, parameterFirst == ":" {
      self.parameters = String(parametersStr[parametersStr.index(parametersStr.startIndex, offsetBy: 1)..<parametersStr.endIndex])
    } else {
      self.parameters = parametersStr
    }
  }
}
