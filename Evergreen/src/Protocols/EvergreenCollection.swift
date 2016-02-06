//
//  EvergreenCollection.swift
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

/// Protocol for the creation of a collection of EvergreenObjects

public protocol EvergreenCollection: EvergreenObjectable, CustomStringConvertible {
    
    /// Elements must conform to EvergreenObjectable
    typealias Element: EvergreenObjectable
    
    /// The collection of Elements
    var items: [Element] { get set }
    
    /// Actual number of elements in the collection
    var count: Int { get }
    
    /// Pagination information
    var _pagination: EvergreenCollectionPaginable { get set }

    /// Datakeys for the Collection type
    var _dataKeys: EvergreenCollectionDataParsable { get set }
    
    /**
     Failable initializer that gets a JSON representing a collection
     
     - parameter collectionJSON: JSON object representing a collection
     
     - returns: nil if impossible to create the collection
     */
    init(json: JSON) throws
}

// MARK: - Default implementation of EvergreenCollection

extension EvergreenCollection {
    
    public var count: Int { return items.count }
}

// MARK: - Default implementation of CustomStringConvertible for EvergreenCollection

extension EvergreenCollection {
    
    public var description: String { return "Actions:\ntotalCount: \(_pagination.totalCount)\ncount: \(count)\nnextPage: \(_pagination.nextPage)\nlastPage: \(_pagination.lastPage)\nprevPage: \(_pagination.prevPage)\nfirstPage: \(_pagination.firstPage)\nitems: \(items)\n\n" }
}