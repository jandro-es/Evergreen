//
//  Account.swift
//  Evergreen
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

public struct Account: EvergreenObjectable {
    
    // MARK: - Private Properties
    
    private let _baseNode = "account"
    
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
    
    // MARK: - Initializers
    
    public init?(data: JSONDictionary) {
        
        guard let accountData = data[_baseNode] as? JSONDictionary else { return nil }
        guard let email = accountData[_dataKeys.Email.rawValue] as? String,
            uuid = accountData[_dataKeys.UUID.rawValue] as? String,
            dropletLimit = accountData[_dataKeys.DropletLimit.rawValue] as? Int,
            floatingIPLimit = accountData[_dataKeys.FloatingIPLimit.rawValue] as? Int,
            accountString = accountData[_dataKeys.Status.rawValue] as? String,
            accountStatus = Status(rawValue: accountString),
            emailVerified = accountData[_dataKeys.EmailVerified.rawValue] as? Bool
            else {
                return nil
        }
        
        self.email = email
        self.uuid = uuid
        self.dropletLimit = dropletLimit
        self.floatingIPLimit = floatingIPLimit
        self.accountStatus = accountStatus
        self.emailVerified = emailVerified
        
        if let accountText = accountData[_dataKeys.StatusMessage.rawValue] as? String {
            self.accountStatusMessage = accountText
        } else {
            self.accountStatusMessage = ""
        }
    }
    
    public init?(response: NSHTTPURLResponse, representation: AnyObject) {
        
        guard let jsonDictionary = representation as? JSONDictionary else { return nil }
        
        self.init(data: jsonDictionary)
    }
}

// MARK: - CustomDebugStringConvertible

extension Account: CustomDebugStringConvertible {
    
    public var debugDescription: String { return "Account:\n email: \(email)\n uuid: \(uuid)\n droplet_limit: \(dropletLimit)\n  floating_ip_limit: \(floatingIPLimit)\n status: \(accountStatus.rawValue)\n status_message: \(accountStatusMessage)\n  email_verified: \(emailVerified)\n" }
}

// MARK: - CustomStringConvertible

extension Account: CustomStringConvertible {
    
    public var description: String { return "Account:\n email: \(email)\n uuid: \(uuid)\n"  }
}

public func ==(lhs: Account, rhs: Account) -> Bool { return lhs.email == rhs.email && lhs.uuid == rhs.uuid }