//
//  DomainRecord.swift
//  Evergreen
//
//  Created by Alejandro Barros Cuetos on 02/04/2016.
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

public struct DomainRecord: EvergreenObjectable {
    
    // MARK: - Private Properties
    
    private static let _kBaseNode = "domain_record"
    
    private enum _dataKeys: String {
        
        case RecordId = "id"
        case RecordType = "type"
        case RecordName = "name"
        case RecordData = "data"
        case RecordPriority = "priority"
        case RecordPort = "port"
        case RecordWeight = "weight"
    }
    
    public let recordId: Int
    public let recordType: String
    public let recordName: String
    public let recordData: String
    public var recordPriority: Int?
    public var recordPort: Int?
    public var recordWeight: Int?
}

// MARK: - JSONDecodable

extension DomainRecord: JSONDecodable {
    
    public init(json: Freddy.JSON) throws {
        let recordJSON: JSON
        do {
            recordJSON = try JSON(json.dictionary(DomainRecord._kBaseNode))
        } catch {
            recordJSON = json
        }
        recordId = try recordJSON.int(DomainRecord._dataKeys.RecordId.rawValue)
        recordType = try recordJSON.string(DomainRecord._dataKeys.RecordType.rawValue)
        recordName = try recordJSON.string(DomainRecord._dataKeys.RecordName.rawValue)
        recordData = try recordJSON.string(DomainRecord._dataKeys.RecordData.rawValue)
        recordPriority = try recordJSON.int(DomainRecord._dataKeys.RecordPriority.rawValue, ifNull: true)
        recordPort = try recordJSON.int(DomainRecord._dataKeys.RecordPort.rawValue, ifNull: true)
        recordWeight = try recordJSON.int(DomainRecord._dataKeys.RecordWeight.rawValue, ifNull: true)
    }
}

// MARK: - CustomStringConvertible

extension DomainRecord: CustomStringConvertible {
    
    public var description: String { return "DomainRecord:\nid: \(recordId)\ntype: \(recordType)\nname: \(recordName)\ndata: \(recordData)\npriority: \(recordPriority)\nport: \(recordPort)\nweight: \(recordWeight)\n\n" }
}

/**
 *  Holds a collection of Domain Records
 */
public struct DomainRecords: EvergreenCollection, JSONDecodable {
    
    // MARK: - Public properties
    
    public var items: [DomainRecord]
    
    public var _pagination: EvergreenCollectionPaginable
    
    public var _dataKeys: EvergreenCollectionDataParsable = EvergreenCollectionDataKeys(collectionNode: "domain_records")
    
    public init(json: JSON) throws {
        items = try json.array(_dataKeys.kCollectionNode!).map(DomainRecord.init)
        _pagination = try EvergreenPagination(json: json, dataKeys: _dataKeys)
    }
}

public func == (lhs: DomainRecord, rhs: DomainRecord) -> Bool { return lhs.recordId == rhs.recordId }