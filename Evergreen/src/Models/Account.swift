//
//  Account.swift
//  Evergreen
//
//  Created by Alejandro Barros Cuetos on 31/01/2016.
//  Copyright © 2016 Alejandro Barros Cuetos. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this
//  list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice,
//  this list of conditions and the following disclaimer in the documentation
//  && and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
//  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
//  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
//  ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
//  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
//  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
//  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
//  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
//  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
//  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
//  POSSIBILITY OF SUCH DAMAGE.
//

import Foundation
import Freddy

public struct Account: EvergreenObjectable {
    
    // MARK: - Private Properties
    
    private static let _kBaseNode = "account"
    
    private enum _dataKeys: String {
        
        case DropletLimit = "droplet_limit"
        case FloatingIPLimit = "floating_ip_limit"
        case Email = "email"
        case UUID = "uuid"
        case EmailVerified = "email_verified"
        case Status = "status"
        case StatusMessage = "status_message"
    }
    
    // MARK: - Public Properties
    
    public enum Status: String {
        
        case Active = "active"
        case Warning = "warning"
        case Locked = "locked"
    }
    
    public let email: String
    public let uuid: String
    public let dropletLimit: Int
    public let emailVerified: Bool
    public let floatingIPLimit: Int
    public let accountStatus: Status
    public let accountStatusMessage: String
}

// MARK: - JSONDecodable

extension Account: JSONDecodable {
    
    public init(json: Freddy.JSON) throws {
        let accountJson = try JSON(json.dictionary(Account._kBaseNode))
        uuid = try accountJson.string(_dataKeys.UUID.rawValue)
        email = try accountJson.string(_dataKeys.Email.rawValue)
        dropletLimit = try accountJson.int(_dataKeys.DropletLimit.rawValue)
        emailVerified = try accountJson.bool(_dataKeys.EmailVerified.rawValue)
        floatingIPLimit = try accountJson.int(_dataKeys.FloatingIPLimit.rawValue)
        accountStatus = try Status(rawValue: accountJson.string(_dataKeys.Status.rawValue))!
        accountStatusMessage = try accountJson.string(_dataKeys.StatusMessage.rawValue)
    }
}

// MARK: - JSONEncodable

extension Account: JSONEncodable {
    
    public func toJSON() -> JSON {
        return .Dictionary([_dataKeys.UUID.rawValue: .String(uuid), _dataKeys.Email.rawValue: .String(email), _dataKeys.DropletLimit.rawValue: .Int(dropletLimit), _dataKeys.EmailVerified.rawValue: .Bool(emailVerified), _dataKeys.FloatingIPLimit.rawValue: .Int(floatingIPLimit), _dataKeys.Status.rawValue: .String(accountStatus.rawValue), _dataKeys.StatusMessage.rawValue: .String(accountStatusMessage)])
    }
}

// MARK: - CustomStringConvertible

extension Account: CustomStringConvertible {
    
    public var description: String { return "Account:\nemail: \(email)\nuuid: \(uuid)\ndroplet_limit: \(dropletLimit)\nfloating_ip_limit: \(floatingIPLimit)\nstatus: \(accountStatus.rawValue)\nstatus_message: \(accountStatusMessage)\nemail_verified: \(emailVerified)\n" }
}

public func ==(lhs: Account, rhs: Account) -> Bool { return lhs.email == rhs.email && lhs.uuid == rhs.uuid }