//
//  Evergreen.swift
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

import Foundation
import Alamofire

public let kEvergreenErrorDomain: String = "com.filtercode.evergreen"

public typealias JSONDictionary = [String:AnyObject]
public typealias JSONArray = [JSONDictionary]

public class Evergreen {
    
    public static let kBaseURLString = "https://api.digitalocean.com/v2"
    
    public typealias OnSuccess = (T: EvergreenObjectable?) -> Void
    public typealias OnDeletionSuccess = () -> Void
    public typealias OnError = (NSError?) -> Void
    
    /**
     API endpoint to get the information of the account for the given API Token
     
     - parameter apiKey:       Digital Ocean API Token
     - parameter queue:        dispatch_queue_t to execute the handlers
     - parameter onCompletion: On success handler
     - parameter onError:      On error handler
     */
    public class func fetchAccount(apiKey: String, queue: dispatch_queue_t = dispatch_get_main_queue(), onCompletion: OnSuccess, onError: OnError) {
        Alamofire.request(AccountRouter.ReadAccount(apiKey)).responseEvergreen { (response: Response<Account, NSError>) -> Void in
            if response.result.isSuccess {
                dispatch_async(queue) {
                    onCompletion(T: response.result.value)
                }
            } else {
                dispatch_async(queue) {
                    onError(response.result.error)
                }
            }
        }
    }
    
    /**
     API endpoint to get the details of an action
     
     - parameter apiKey:       Digital Ocean API Token
     - parameter actionId:     The id of the action
     - parameter queue:        dispatch_queue_t to execute the handlers
     - parameter onCompletion: On success handler
     - parameter onError:      On error handler
     */
    public class func fetchAction(apiKey: String, actionId: Int, queue: dispatch_queue_t = dispatch_get_main_queue(), onCompletion: OnSuccess, onError: OnError) {
        Alamofire.request(ActionRouter.ReadAction(apiKey, actionId)).responseEvergreen { (response: Response<Action, NSError>) -> Void in
            if response.result.isSuccess {
                dispatch_async(queue) {
                    onCompletion(T: response.result.value)
                }
            } else {
                dispatch_async(queue) {
                    onError(response.result.error)
                }
            }
        }
    }
    
    /**
     API endpoint to get a collection of actions
     
     - parameter apiKey:       Digital Ocean API Token
     - parameter page:         Page number
     - parameter queue:        dispatch_queue_t to execute the handlers
     - parameter onCompletion: On success handler
     - parameter onError:      On error handler
     */
    public class func fetchActions(apiKey: String, page: Int = 1, queue: dispatch_queue_t = dispatch_get_main_queue(), onCompletion: OnSuccess, onError: OnError) {
        Alamofire.request(ActionRouter.ReadActions(apiKey, page)).responseEvergreen { (response: Response<Actions, NSError>) -> Void in
            if response.result.isSuccess {
                dispatch_async(queue) {
                    onCompletion(T: response.result.value)
                }
            } else {
                dispatch_async(queue) {
                    onError(response.result.error)
                }
            }
        }
    }
    
    /**
     API endpoint to get the details of a domain
     
     - parameter apiKey:       Digital Ocean API Token
     - parameter domainName:   The name of the domain
     - parameter queue:        dispatch_queue_t to execute the handlers
     - parameter onCompletion: On success handler
     - parameter onError:      On error handler
     */
    public class func fetchDomain(apiKey: String, domainName: String, queue: dispatch_queue_t = dispatch_get_main_queue(), onCompletion: OnSuccess, onError: OnError) {
        Alamofire.request(DomainRouter.ReadDomain(apiKey, domainName)).responseEvergreen { (response: Response<Domain, NSError>) -> Void in
            if response.result.isSuccess {
                dispatch_async(queue) {
                    onCompletion(T: response.result.value)
                }
            } else {
                dispatch_async(queue) {
                    onError(response.result.error)
                }
            }
        }
    }
    
    /**
     API endpoint to get a collection of actions
     
     - parameter apiKey:       Digital Ocean API Token
     - parameter page:         Page number
     - parameter queue:        dispatch_queue_t to execute the handlers
     - parameter onCompletion: On success handler
     - parameter onError:      On error handler
     */
    public class func fetchDomains(apiKey: String, page: Int = 1, queue: dispatch_queue_t = dispatch_get_main_queue(), onCompletion: OnSuccess, onError: OnError) {
        Alamofire.request(DomainRouter.ReadDomains(apiKey, page)).responseEvergreen { (response: Response<Domains, NSError>) -> Void in
            if response.result.isSuccess {
                dispatch_async(queue) {
                    onCompletion(T: response.result.value)
                }
            } else {
                dispatch_async(queue) {
                    onError(response.result.error)
                }
            }
        }
    }
    
    /**
     API endpoint to create a Domain
     
     - parameter apiKey:       Digital Ocean API Token
     - parameter values:       Dictionary with the required values ["name": String, "ip_address": String]
     - parameter queue:        dispatch_queue_t to execute the handlers
     - parameter onCompletion: On success handler
     - parameter onError:      On error handler
     */
    public class func createDomain(apiKey: String, values: [String:AnyObject], queue: dispatch_queue_t = dispatch_get_main_queue(), onCompletion: OnSuccess, onError: OnError) {
        Alamofire.request(DomainRouter.CreateDomain(apiKey, values)).responseEvergreen { (response: Response<Domain, NSError>) -> Void in
            if response.result.isSuccess {
                dispatch_async(queue) {
                    onCompletion(T: response.result.value)
                }
            } else {
                dispatch_async(queue) {
                    onError(response.result.error)
                }
            }
        }
    }
    
    /**
     API endpoint to delete a Domain
     
     - parameter apiKey:            Digital Ocean API Token
     - parameter domainName:        The name of the Domain
     - parameter queue:             dispatch_queue_t to execute the handlers
     - parameter onDeletionSuccess: On success handler
     - parameter onError:           On error handler
     */
    public class func deleteDomain(apiKey: String, domainName: String, queue: dispatch_queue_t = dispatch_get_main_queue(), onDeletionSuccess: OnDeletionSuccess, onError: OnError) {
        Alamofire.request(DomainRouter.DeleteDomain(apiKey, domainName)).response { request, response, data, error in
            if let error = error {
                dispatch_async(queue) {
                    onError(error)
                }
            } else {
                if response!.statusCode == 204 {
                    dispatch_async(queue) {
                        onDeletionSuccess()
                    }
                } else {
                    dispatch_async(queue) {
                        onError(NSError(domain: kEvergreenErrorDomain, code: response!.statusCode, userInfo: [NSLocalizedDescriptionKey: "Error while deleting a domain"]))
                    }
                }
            }
        }
    }
}