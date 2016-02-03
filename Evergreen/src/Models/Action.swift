//
//  Action.swift
//  Evergreen
//
//  Created by Alejandro Barros Cuetos on 01/02/2016.
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

public struct Action: EvergreenObjectable {
    
    // TODO: Meta and links
    
    // MARK: - Private Properties
    
    private static let _kBaseNode = "action"
    
    private enum _dataKeys: String {
        
        case ActionId = "id"
        case Status = "status"
        case ActionType = "type"
        case CompletedAt = "completed_at"
        case StartedAt = "started_at"
        case ResourceId = "resource_id"
        case ResourceType = "resource_type"
        case RegionSlug = "region_slug"
    }
    
    // MARK: - Public Properties
    
    public enum Status: String {
        
        case Completed = "completed"
        case InProgress = "in-progress"
        case Errored = "errored"
    }
    
    public let actionId: Int
    public let status: Status
    public let actionType: String
    public let completedAt: NSDate?
    public let startedAt: NSDate?
    public let resourceId: Int
    public let resourceType: String
    public let regionSlug: String?
}

// MARK: - JSONDecodable

extension Action: JSONDecodable {
    
    public init(json: Freddy.JSON) throws {
        let actionJSON: JSON
        do {
            actionJSON = try JSON(json.dictionary(Action._kBaseNode))
        } catch {
            actionJSON = json
        }
        actionId = try actionJSON.int(_dataKeys.ActionId.rawValue)
        status = try Status(rawValue: actionJSON.string(_dataKeys.Status.rawValue))!
        actionType = try actionJSON.string(_dataKeys.ActionType.rawValue)
        resourceId = try actionJSON.int(_dataKeys.ResourceId.rawValue)
        resourceType   = try actionJSON.string(_dataKeys.ResourceType.rawValue)
        regionSlug = try actionJSON.string(_dataKeys.RegionSlug.rawValue)
        startedAt = try NSDate.dateFromISO8601(actionJSON.string(_dataKeys.StartedAt.rawValue))
        completedAt = try NSDate.dateFromISO8601(actionJSON.string(_dataKeys.CompletedAt.rawValue))
    }
}

// MARK: - CustomStringConvertible

extension Action: CustomStringConvertible {
    
    public var description: String { return "Action:\nid: \(actionId)\ntype: \(actionType)\nstatus: \(status.rawValue)\ncompletedAt: \(completedAt)\nstartedAt: \(startedAt)\ncompleteAt: \(completedAt)\nresourceId: \(resourceId)\nresourceType: \(resourceType)\nregionSlug: \(regionSlug)\n\n" }
}

public struct Actions: EvergreenCollection, JSONDecodable {
    
    // MARK: - Private properties
    
    private enum _dataKeys: String {
        
        case MetaNode = "meta"
        case LinksNode = "links"
        case CollectionNode = "actions"
        case MetaTotalLeaf = "total"
        case LinksPagesNode = "pages"
        case LinksPageLastLeaf = "last"
        case LinksPageNextLeaf = "next"

    }
    
    // MARK: - Public properties
    
    public var items: [Action]

    public var totalCount: Int
    
    public var nextPage: Int?
    
    public var lastPage: Int?
    
    public init(json: JSON) throws {
        items = try json.array(_dataKeys.CollectionNode.rawValue).map(Action.init)
        totalCount = try json.int(_dataKeys.MetaNode.rawValue, _dataKeys.MetaTotalLeaf.rawValue)
       // nextPage = try json.int(_dataKeys.LinksNode.rawValue, _dataKeys.LinksPagesNode.rawValue, _dataKeys.LinksPageNextLeaf.rawValue)
       // lastPage = try json.int(_dataKeys.LinksNode.rawValue, _dataKeys.LinksPagesNode.rawValue, _dataKeys.LinksPageLastLeaf.rawValue)
    }
}

// MARK: - CustomStringConvertible

extension Actions: CustomStringConvertible {
    
    public var description: String { return "Actions:\ntotalCount: \(totalCount)\ncount: \(count)\nnextPage: \(nextPage)\nlastPage: \(lastPage)\nitems: \(items)\n\n" }
}

public func ==(lhs: Action, rhs: Action) -> Bool { return lhs.actionId == rhs.actionId && lhs.actionType == rhs.actionType }