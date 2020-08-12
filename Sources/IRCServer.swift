//
//  IRCServer.swift
//  IRC iOS
//
//  Created by Harry Stanton on 2/29/20.
//

import Foundation

public class IRCServer: NSObject, StreamDelegate {
  
  public enum Error: Swift.Error {
    case sslConfigFailed
    case notConnected
    case alreadyConnected
    case dataCreationError
    case stringTooLarge
    case notInChannel
  }
  
  let maxReadLength = 512
  
  public var readStream: Unmanaged<CFReadStream>?
  public var writeStream: Unmanaged<CFWriteStream>?
  public var inputStream: InputStream?
  public var outputStream: OutputStream?
  
  private var socketConnected = false
  private(set) public var connected = false
  private(set) public var activeChannels = [String]()
  
  let hostname: String
  let port: Int
  let password: String?
  let ssl: Bool
  let user: IRCUser
  
  public var delegate: IRCServerDelegate?
  
  private var recvBuffer: String?
  
  public init(hostname: String, port: Int, password: String?, ssl: Bool, user: IRCUser) {
    self.hostname = hostname
    self.port = port
    self.password = password
    self.ssl = ssl
    self.user = user
  }
  
  public func connect() throws {
    guard !connected else {
      throw Error.alreadyConnected
    }
    
    CFStreamCreatePairWithSocketToHost(kCFAllocatorDefault, hostname as CFString, UInt32(port), &readStream, &writeStream)

    inputStream = readStream!.takeRetainedValue()
    outputStream = writeStream!.takeRetainedValue()

    if ssl == true {
      let dict = [
        kCFStreamSSLValidatesCertificateChain: kCFBooleanFalse,
        kCFStreamSSLLevel: "kCFStreamSocketSecurityLevelTLSv1_2"
        ] as CFDictionary

      let sslSetRead = CFReadStreamSetProperty(inputStream, CFStreamPropertyKey(kCFStreamPropertySSLSettings), dict)
      let sslSetWrite = CFWriteStreamSetProperty(outputStream, CFStreamPropertyKey(kCFStreamPropertySSLSettings), dict)

      if sslSetRead == false || sslSetWrite == false {
        throw IRCServer.Error.sslConfigFailed
      }
    }

    inputStream?.delegate = self

    inputStream?.schedule(in: .current, forMode: RunLoop.Mode.common)
    outputStream?.schedule(in: .current, forMode: RunLoop.Mode.common)
    
    inputStream?.open()
    outputStream?.open()

    register()
  }
  
  public func disconnect() {
    do {
      try send(raw: "QUIT")
    } catch { }
    
    inputStream?.close()
    outputStream?.close()
  }
  
  public func join(channel: String) throws {
    guard connected else {
      throw Error.notConnected
    }
    
    try send(raw: "JOIN \(channel)")
  }
  
  public func send(message: String, in channel: String) throws {
    guard activeChannels.firstIndex(of: channel) != nil else {
      throw Error.notInChannel
    }
    try send(raw: "PRIVMSG \(channel) :\(message)")
  }
  
  private func send(raw string: String, appendCRLF: Bool = true) throws {
    guard let data = "\(string)\(appendCRLF ? "\r\n" : "")".data(using: .utf8) else {
      throw Error.dataCreationError
    }
    
    guard data.count <= 512 else {
      throw Error.stringTooLarge
    }
    
    try data.withUnsafeBytes { body in
      guard let pointer = body.baseAddress?.assumingMemoryBound(to: UInt8.self) else {
        throw Error.dataCreationError
      }
      
      outputStream?.write(pointer, maxLength: data.count)
      
    }
  }
  
  private func handle(message: IRCMessage) {
    
    do {
      if let command = message.command {
        switch command {
        case .ping:
          try send(raw: "PONG")
        case .join:
          guard message.parameters.count > 0 else {
            break
          }
          let newChan = String(message.parameters.split(separator: " ")[0])
          activeChannels.append(newChan)
          
          delegate?.ircEvent(server: self, joined: newChan)
        case .privmsg:
          print("PRIVMSG")
          print(message.raw)
//          print(message.parameters)
        default:
          delegate?.ircEvent(server: self, rawMessage: message)
          break
        }
      } else if let numericResponse = message.numericResponse {
//        print("reply: \(numericResponse)")
        switch numericResponse {
        case .replyWelcome:
          self.connected = true
          delegate?.ircConnected(server: self)
        default:
          break
        }
      }
    } catch {
      print("handle error: \(error)")
    }
    
  }
  
  func parseAvailableBytes(stream: InputStream) -> String? {
    let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: maxReadLength)
    let numberOfBytesRead = stream.read(buffer, maxLength: maxReadLength)
    
    let parsedString = String(bytesNoCopy: buffer, length: numberOfBytesRead, encoding: .utf8, freeWhenDone: true)
    return parsedString
  }
  
  public func register() {
    do {
      if let password = password {
        try send(raw: "PASS \(password)\r\n")
      }
      try send(raw: "NICK \(user.nick)\r\n")
      try send(raw: "USER \(user.username) * * :\(user.realname)\r\n")
      print("done")
    } catch {
      print(error)
    }
  }
  
  // MARK: - StreamDelegate
  
  private func cut(recv string: String) {
    let strings = string.components(separatedBy: .newlines).filter { $0.count > 0 }
    for string in strings {
      do {
        let ircMessage = try IRCMessage(parse: string)
        handle(message: ircMessage)
      } catch {
        print(error)
      }
    }
  }
  
  public func stream(_ aStream: Stream, handle eventCode: Stream.Event) {
    
    if eventCode == .openCompleted {
      self.socketConnected = true
    } else if eventCode == .endEncountered {
      self.connected = false
      self.socketConnected = false
      self.activeChannels = []
      
      delegate?.ircDisconnected(server: self)
    } else if eventCode == .hasBytesAvailable {
      if let inputStream = aStream as? InputStream, let str = parseAvailableBytes(stream: inputStream) {
        let suffix = String(str.suffix(1))
        if suffix == "\r\n" {
          if let recvBuffer = recvBuffer {
            let finalString = recvBuffer + str
            cut(recv: finalString)
            self.recvBuffer = nil
          } else {
            cut(recv: str)
          }
        } else {
          if let recvBuffer = recvBuffer {
            self.recvBuffer = recvBuffer + str
          } else {
            self.recvBuffer = str
          }
        }
      }
    }
    
  }
  
}
