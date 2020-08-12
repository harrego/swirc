//
//  IRCNumericResponse.swift
//  IRC
//
//  Created by Harry Stanton on 3/1/20.
//

import Foundation

public enum IRCNumericResponse: String {
  
  // 5.1 Command responses
  
  case replyWelcome = "001"
  case replyYourHost = "002"
  case replyCreated = "003"
  case replyMyInfo = "004"
  case replyBounce = "005"
  
  case replyUserHost = "302"
  case replyISON = "303"
  case replyAway = "301"
  case replyUnaway = "305"
  case replyNowAway = "306"
  case replyWhoIsUser = "311"
  case replyWhoIsServer = "312"
  case replyWhoIsOperator = "313"
  case replyWhoIsIdle = "317"
  case replyEndOfWhoIs = "318"
  case replyWhoIsChannels = "319"
  case replyWhoWasUser = "314"
  case replyEndOfWhoWas = "369"
  case replyListStart = "321"
  case replyList = "322"
  case replyListEnd = "323"
  case replyUniqOpIs = "325"
  case replyChannelModeIs = "324"
  case replyNoTopic = "331"
  case replyTopic = "332"
  case replyInviting = "341"
  case replySummoning = "342"
  case replyInviteList = "346"
  case replyEndOfInviteList = "347"
  case replyExceptList = "348"
  case replyEndOfExceptList = "349"
  case replyVersion = "351"
  case replyWhoReply = "352"
  case replyEndOfWho = "315"
  case replyNamReply = "353"
  case replyEndOfNames = "366"
  case replyLinks = "364"
  case replyEndOfLinks = "265"
  case replyBanList = "367"
  case replyEndOfBanList = "368"
  case replyInfo = "371"
  case replyEndOfInfo = "374"
  case replyMotdStart = "375"
  case replyMotd = "372"
  case replyEndOfMotd = "376"
  case replyYoureOper = "381"
  case replyRehashing = "382"
  case replyYoureService = "383"
  case replyTime = "391"
  case replyUserStart = "392"
  case replyUsers = "393"
  case replyEndOfUsers = "394"
  case replyNoUsers = "395"
  
  case replyTraceLink = "200"
  case replyTraceConnecting = "201"
  case replyTraceHandshake = "202"
  case replyTraceUnknown = "203"
  case replyTraceOperator = "204"
  case replyTraceUser = "205"
  case replyTraceServer = "206"
  case replyTraceService = "207"
  case replyTraceNewType = "208"
  case replyTraceClass = "209"
  case replyTraceReconnect = "210"
  case replyTraceLog = "261"
  case replyTraceEnd = "262"
  case replyStatsLinkInfo = "211"
  case replyStatsCommand = "212"
  case replyEndOfStats = "219"
  case replyStatsUpTime = "242"
  case replyStatsOLine = "243"
  case replyUModeIs = "221"
  case replyServList = "234"
  case replyServListEnd = "235"
  case replyLUserClient = "251"
  case replyLUserOp = "252"
  case replyLUserUnknown = "253"
  case replyLUserChannels = "254"
  case replyLUserMe = "255"
  case replyAdminMe = "256"
  case replyAdminLoc1 = "257"
  case replyAdminLoc2 = "258"
  case replyAdminEmail = "259"
  case replyTryAgain = "263"
  
  // 5.2 Error Replies
  
  case errorNoSuchNick = "401"
  case errorNoSuchServer = "402"
  case errorNoSuchChannel = "403"
  case errorCannotSendToChan = "404"
  case errorTooManyChannels = "405"
  case errorWasNoSuchNick = "406"
  case errorTooManyTargets = "407"
  case errorNoSuchService = "408"
  case errorNoOrigin = "409"
  case errorNoRecipient = "411"
  case errorNoTextToSend = "412"
  case errorNoTopLevel = "413"
  case errorWildTopLevel = "414"
  case errorBadMask = "415"
  case errorUnknownCommand = "421"
  case errorNoMotd = "422"
  case errorNoAdminInfo = "423"
  case errorFileError = "424"
  case errorNoNicknameGiven = "431"
  case errorErroneusNick = "432"
  case errorNicknameInUse = "433"
  case errorNickCollision = "436"
  case errorUnavailResource = "437"
  case errorUserNotInChannel = "441"
  case errorNotOnChannel = "442"
  case errorUserOnChannel = "443"
  case errorNoLogin = "444"
  case errorSummonDisabled = "445"
  case errorUsersDisabled = "446"
  case errorNotRegistered = "451"
  case errorNeedMoreParams = "461"
  case errorAlreadyRegistered = "462"
  case errorNoPermForHost = "463"
  case errorPasswdMismatch = "464"
  case errorYoureBannedCreep = "465"
  case errorYouWillBeBanned = "466"
  case errorKeySet = "467"
  case errorChannelIsFull = "471"
  case errorUnknownMode = "472"
  case errorInviteOnlyChan = "473"
  case errorBannedFromChan = "474"
  case errorBadChannelKey = "475"
  case errorBadChanMask = "476"
  case errorNoChanModes = "477"
  case errorBanListFull = "481"
  case errorChanOPrivNedded = "482"
  case errorCantKillServer = "483"
  case errorRestricted = "484"
  case errorUniqOpPrivsNeeded = "485"
  case errorNoOperHost = "491"
  
  case errorUModeUnknownFlag = "501"
  case errorUsersDontMatch = "502"
}