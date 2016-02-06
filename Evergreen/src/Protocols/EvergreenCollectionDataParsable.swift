//
//  EvergreenCollectionDataKeys.swift
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

/**
 *  Protocol for DataKeys in EvergreenCollections
 */
public protocol EvergreenCollectionDataParsable {
    
    /// The string for the meta node
    var kMetaNode: String! { get }
    
    /// The string for the links node
    var kLinksNode: String! { get }
    
    /// The string for the collection node
    var kCollectionNode: String! { get set }
    
    /// The string for the total count leaf
    var kMetaTotalLeaf: String! { get }
    
    /// The string for the pages node
    var kLinksPagesNode: String! { get }
    
    /// The string for the last page leaf
    var kLinksPageLastLeaf: String! { get }
    
    /// The string for the next page leaf
    var kLinksPageNextLeaf: String! { get }
    
    /// The string for the previous page leaf
    var kLinksPagePrevLeaf: String! { get }
    
    /// The string for the first page leaf
    var kLinksPageFirstLeaf: String! { get }
}

// MARK: - Default implementation for EvergreenCollectionDataKeys

extension EvergreenCollectionDataParsable {
    
    public var kMetaNode: String! { return "meta" }
    public var kLinksNode: String! { return "links" }
    public var kMetaTotalLeaf: String! { return "total" }
    public var kLinksPagesNode: String! { return "pages" }
    public var kLinksPageLastLeaf: String! { return "last" }
    public var kLinksPageNextLeaf: String! { return "next" }
    public var kLinksPagePrevLeaf: String! { return "prev" }
    public var kLinksPageFirstLeaf: String! { return "first" }
}