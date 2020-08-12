#  Example Implementation

## NSViewController

```
import Cocoa
import IRC

class ViewController: NSViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    let server = IRCServer(hostname: "chat.freenode.net", port: 6667, password: nil, ssl: false, user: IRCUser(nick: "testuser1", username: "testuser1", realname: "testuser1"))
    server.delegate = self
    do {
      try server.connect()
      try server.join(channel: "#testchannel")
      
    } catch {
      print("error: \(error)")
    }
    
    // Do any additional setup after loading the view.
  }

  override var representedObject: Any? {
    didSet {
    // Update the view, if already loaded.
    }
  }


}

extension ViewController: IRCServerDelegate {
  func ircEvent(server: IRCServer, joined channel: String) {
    print("joined chan: \(channel), joined chans: \(server.activeChannels)")
  }
  
  func ircEvent(server: IRCServer, left channel: String) {
    print("left chan: \(channel), joined chans: \(server.activeChannels)")
  }
  
  func ircEvent(server: IRCServer, user: IRCUser, joined channel: String) {
    //
  }
  
  func ircEvent(server: IRCServer, user: IRCUser, left channel: String) {
    //
  }
  
  func ircEvent(server: IRCServer, rawMessage: IRCMessage) {
    print("raw msg: command: \(rawMessage.command) parameters: \(rawMessage.parameters) prefix: \(rawMessage.prefix) raw: \(rawMessage.raw)")
  }
  
  
  func ircConnected(server: IRCServer) {
    print("connected")
  }
  
  func ircDisconnected(server: IRCServer) {
    print("disconnected")
  }
  
}

```

