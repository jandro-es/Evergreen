//
//  DomainRecordRouter.swift
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

import Foundation
import Alamofire

enum DomainRecordRouter: URLRequestConvertible {
    
    /**
     *  Gets the info of a single domain record
     *
     *  @param String API Key
     *  @param String Domain name
     *  @param Int ID of the record
     *
     *  @return API Endpoint
     */
    case ReadDomainRecord(String, String, Int)
    
    /**
     *  Gets all the domain records
     *
     *  @param String API Key
     *  @param String Domain name
     *  @param Int page number
     *
     *  @return API Endpoint
     */
    case ReadDomainRecords(String, String, Int)
    
    /**
     *  Creates a new domain record
     *
     *  @param String API Key
     *  @param String Domain name
     *  @param [String : AnyObject]
     *
     *  @return API Endpoint
     */
    case CreateDomainRecord(String, String, [String : AnyObject])
    
    /**
     *  Updates a domain record
     *
     *  @param String API Key
     *  @param String Domain name
     *  @param Int ID of the record
     *  @param [String : AnyObject]
     *
     *  @return API Endpoint
     */
    case UpdateDomainRecord(String, String, [String : AnyObject])
    
    /**
     *  Deletes a Domain record
     *
     *  @param String API Key
     *  @param String Domain name
     *  @param Int ID of the record
     *
     *  @return API Endpoint
     */
    case DeleteDomainRecord(String, String, Int)
    
    var method: Alamofire.Method {
        switch self {
        case .ReadDomainRecord, .ReadDomainsRecords:
            return .GET
            
        case .CreateDomainRecord:
            return .POST
            
        case .DeleteDomainRecord:
            return .DELETE
            
        case .UpdateDomainRecord:
            return .PUT
        }
    }
    
    var path: String {
        switch self {
        case .ReadDomainRecord(_, let domainName, let recordId):
            return "/domains/\(domainName)/records/\(recordId)"
            
        case .ReadDomainRecords(_, _), .CreateDomain(_, _):
            return "/domains"
            
        case .DeleteDomain(_, let domainName):
            return "/domains/\(domainName)"
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
        
        case .CreateDomain(let apiKey, let parameters):
            mutableURLRequest.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
            return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: parameters).0
            
        case .DeleteDomain(let apiKey, _):
            mutableURLRequest.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
            return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: nil).0
        }
    }
}