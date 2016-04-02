//
//  Domain.swift
//  Evergreen
//
//  Created by Alejandro Barros Cuetos on 07/02/2016.
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

public struct Domain: EvergreenObjectable {
    
    // MARK: - Private Properties
    
    private static let _kBaseNode = "domain"
    
    private enum _dataKeys: String {
        
        case DomainName = "name"
        case TTL = "ttl"
        case ZoneFile = "zone_file"
    }
    
    public let domainName: String
    public var ttl: Int?
    public var zoneFile: String?
}

// MARK: - JSONDecodable

extension Domain: JSONDecodable {
    
    public init(json: Freddy.JSON) throws {
        let domainJSON: JSON
        do {
            domainJSON = try JSON(json.dictionary(Domain._kBaseNode))
        } catch {
            domainJSON = json
        }
        domainName = try domainJSON.string(_dataKeys.DomainName.rawValue)
        do {
            ttl = try domainJSON.int(_dataKeys.TTL.rawValue)
            zoneFile = try domainJSON.string(_dataKeys.ZoneFile.rawValue)
        } catch {
            debugPrint("Not able to parse TTL or ZoneFile")
        }
    }
}

// MARK: - JSONEncodable

extension Domain: JSONEncodable {
    
    public func toJSON() -> JSON {
        return .Dictionary([_dataKeys.DomainName.rawValue: .String(domainName), _dataKeys.TTL.rawValue: .Int(ttl ?? 0), _dataKeys.ZoneFile.rawValue: .String(zoneFile ?? "")])
    }
}

// MARK: - CustomStringConvertible

extension Domain: CustomStringConvertible {
    
    public var description: String { return "Domain:\nname: \(domainName)\nttl: \(ttl)\nzone file: \(zoneFile)\n\n" }
}

/**
 *  Holds a collection of Domains
 */
public struct Domains: EvergreenCollection, JSONDecodable {
    
    // MARK: - Public properties
    
    public var items: [Domain]
    
    public var _pagination: EvergreenCollectionPaginable
    
    public var _dataKeys: EvergreenCollectionDataParsable = EvergreenCollectionDataKeys(collectionNode: "domains")
    
    public init(json: JSON) throws {
        items = try json.array(_dataKeys.kCollectionNode!).map(Domain.init)
        _pagination = try EvergreenPagination(json: json, dataKeys: _dataKeys)
    }
}

public func == (lhs: Domain, rhs: Domain) -> Bool { return lhs.domainName == rhs.domainName }