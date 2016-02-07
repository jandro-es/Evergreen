//
//  DomainRouter.swift
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

import Foundation
import Alamofire

enum DomainRouter: URLRequestConvertible {
    
    /**
     *  Gets the info of a single domain
     *
     *  @param String API Key
     *  @param String Domain name
     *
     *  @return API Endpoint
     */
    case ReadDomain(String, String)
    
    /**
     *  Gets all the domains
     *
     *  @param String API Key
     *  @param Int page number
     *
     *  @return API Endpoint
     */
    case ReadDomains(String, Int)
    
    var method: Alamofire.Method {
        switch self {
        case .ReadDomain, .ReadDomains:
            return .GET
        }
    }
    
    var path: String {
        switch self {
        case .ReadDomain(_, let domainName):
            return "/domains/\(domainName)"
            
        case .ReadDomains(_, _):
            return "/domains"
        }
    }
    
    // MARK: URLRequestConvertible
    
    var URLRequest: NSMutableURLRequest {
        let URL = NSURL(string: Evergreen.kBaseURLString)!
        let mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
        mutableURLRequest.HTTPMethod = method.rawValue
        
        mutableURLRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        mutableURLRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        
        switch self {
        case .ReadDomain(let apiKey, _):
            mutableURLRequest.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
            return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: nil).0
            
        case .ReadDomains(let apiKey, let pageNumber):
            mutableURLRequest.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
            return Alamofire.ParameterEncoding.URLEncodedInURL.encode(mutableURLRequest, parameters: ["page": pageNumber]).0
        }
    }
}