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

public struct Action: EvergreenObjectable {
    
    // TODO: Meta and links
    
    // MARK: - Private Properties
    
    private static let _kBaseNode = "action"
    private static let _kMetaNode = "meta"
    private static let _kLinksNode = "links"
    private static let _kCollectionNode = "actions"
    
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
    public let completedAt: NSDate
    public let startedAt: NSDate
    public let resourceId: Int
    public let resourceType: String
    public let regionSlug: String?
    
    // MARK: - Initializers
    
    public init?(data: JSONDictionary) {
        guard let actionData = data[Action._kBaseNode] as? JSONDictionary else { return nil }
        guard let actionId = actionData[_dataKeys.ActionId.rawValue] as? Int,
            statusString = actionData[_dataKeys.Status.rawValue] as? String,
            status = Status(rawValue: statusString),
            actionType = actionData[_dataKeys.ActionType.rawValue] as? String,
            resourceId = actionData[_dataKeys.ResourceId.rawValue] as? Int,
            resourceType = actionData[_dataKeys.ResourceType.rawValue] as? String,
            startedAtString = actionData[_dataKeys.StartedAt.rawValue] as? String,
            completedAtString = actionData[_dataKeys.CompletedAt.rawValue] as? String
            else {
                return nil
        }
        
        self.actionId = actionId
        self.status = status
        self.actionType = actionType
        self.resourceId = resourceId
        self.resourceType = resourceType
        self.regionSlug = actionData[_dataKeys.RegionSlug.rawValue] as? String
        self.startedAt = NSDate.dateFromISO8601(startedAtString) ?? NSDate()
        self.completedAt = NSDate.dateFromISO8601(completedAtString) ?? NSDate()
    }
    
    public init?(response: NSHTTPURLResponse, representation: AnyObject) {
        guard let jsonDictionary = representation as? JSONDictionary else { return nil }
        
        self.init(data: jsonDictionary)
    }
}

// MARK: - CustomStringConvertible

extension Action: CustomStringConvertible {
    
    public var description: String { return "Action:\nid: \(actionId)\ntype: \(actionType)\nstatus: \(status.rawValue)\ncompletedAt: \(completedAt)\nstartedAt: \(startedAt)\ncompleteAt: \(completedAt)\nresourceId: \(resourceId)\nresourceType: \(resourceType)\nregionSlug: \(regionSlug)\n\n" }
}

// MARK: - EvergreenCollection

extension Action: EvergreenCollection {
    
    public init?(baseNode: String, data: JSONDictionary) {
    
        self.init(data: [baseNode: data])
    }
    
    public static func collection(response response: NSHTTPURLResponse, representation: AnyObject) -> [Action] {
        
        guard let data = (representation as? JSONDictionary)?[Action._kCollectionNode] as? JSONArray else {
            fatalError("Error while casting representation to JSONDictionary")
        }
        var collection = [Action]()
        for itemData: JSONDictionary in data  {
            if let action = Action(baseNode: Action._kBaseNode, data: itemData) {
                collection.append(action)
            }
        }
        
        return collection
    }
}

public func ==(lhs: Action, rhs: Action) -> Bool { return lhs.actionId == rhs.actionId && lhs.actionType == rhs.actionType }