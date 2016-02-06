//
//  EvergreenPagination.swift
//  Evergreen
//
//  Created by Alejandro Barros Cuetos on 06/02/2016.
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

public struct EvergreenPagination: EvergreenCollectionPaginable {
    
    public var totalCount: Int?
    
    public var nextPage: Int?
    
    public var lastPage: Int?
    
    public var firstPage: Int?
    
    public var prevPage: Int?
    
    public init(json: JSON, dataKeys: EvergreenCollectionDataParsable) throws {
        totalCount = try json.int(dataKeys.kMetaNode, dataKeys.kMetaTotalLeaf)
        if let nextPageString = try? NSURL(string: json.string(dataKeys.kLinksNode, dataKeys.kLinksPagesNode, dataKeys.kLinksPageNextLeaf))?.getQueryValues("page")?.first {
            nextPage = Int(nextPageString!)
        }
        if let prevPageString = try? NSURL(string: json.string(dataKeys.kLinksNode, dataKeys.kLinksPagesNode, dataKeys.kLinksPagePrevLeaf))?.getQueryValues("page")?.first {
            prevPage = Int(prevPageString!)
        }
        if let lastPageString = try? NSURL(string: json.string(dataKeys.kLinksNode, dataKeys.kLinksPagesNode, dataKeys.kLinksPageLastLeaf))?.getQueryValues("page")?.first {
            lastPage = Int(lastPageString!)
        }
        if let firstPageString = try? NSURL(string: json.string(dataKeys.kLinksNode, dataKeys.kLinksPagesNode, dataKeys.kLinksPageFirstLeaf))?.getQueryValues("page")?.first {
            firstPage = Int(firstPageString!)
        }
    }
}