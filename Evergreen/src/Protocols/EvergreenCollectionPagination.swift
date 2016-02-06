//
//  EvergreenCollectionPagination.swift
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

/**
 *  Protocol for Evergreen Collections pagination
 */
public protocol EvergreenCollectionPaginable {
    
    /// The total number of elements available
    var totalCount: Int? { get set }
    
    /// The next page to load if there is any
    var nextPage: Int? { get set }
    
    /// The last page to load if there is any
    var lastPage: Int? { get set }
    
    /// The first page if it´s not in the first one
    var firstPage: Int? { get set }
    
    /// The previous page if there is any
    var prevPage: Int? { get set }

    /**
     Creates an instance of EvergreenCollectionPaginable using
     the provided JSON and EvergreenCollectionDataKeys
     
     - parameter json:     The JSON object with pagination information
     - parameter dataKeys: The EvergreenCollectionDataKeys to use
     
     - throws: JSON.Error
     
     - returns: An instance of EvergreenCollectionPaginable
     */
    init(json: JSON, dataKeys: EvergreenCollectionDataParsable) throws
}
