//
//  UserAuthentication.swift
//  WhiteBoard
//
//  Created by jinmao on 2016/12/21.
//  Copyright © 2016年 jinmao. All rights reserved.
//

import Foundation

class UserAuthentication {
    var user: String?
    private var authFlag: UserOptions = .privilege
    var authenticated: Bool {
        return self.authFlag.contains(.login)
    }
    
    private init() {
        // do nothing - stop instances being created
    }
    
    func authenticate(user: String, pass: String) {
        self.authFlag.insert(.login)
    }
    
    class var sharedInstance: UserAuthentication {
        get {
            struct singletonWrapper {
                static let singleton = UserAuthentication()
            }
            return singletonWrapper.singleton
        }
    }
    
}

struct UserOptions: OptionSet {
    let rawValue: Int
    static let login = UserOptions(rawValue: 1 << 0 )
    static let portrait = UserOptions(rawValue: 1 << 1 )
    static let drawMsg = UserOptions(rawValue: 1 << 2 )
    static let voiceMsg = UserOptions(rawValue: 1 << 3 )
    
    static let fresh: UserOptions = []
    static let privilege: UserOptions = [.login, .portrait, .drawMsg, .voiceMsg]
}
