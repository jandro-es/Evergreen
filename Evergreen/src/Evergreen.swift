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
    
    /**
     API endpoint to get the information of the account for the given API Token
     
     - parameter apiKey:       Digital Ocean API Token
     - parameter queue:        dispatch_queue_t to execute the handlers
     - parameter onCompletion: On success handler
     - parameter onError:      On error handler
     */
    public class func fetchAccount(apiKey: String, queue: dispatch_queue_t = dispatch_get_main_queue(), onCompletion: (Account?) -> Void, onError: (NSError?) -> Void) {
        Alamofire.request(AccountRouter.ReadAccount(apiKey)).responseEvergreen { (response: Response<Account, NSError>) -> Void in
            if response.result.isSuccess {
                dispatch_async(queue) {
                    onCompletion(response.result.value)
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
    public class func fetchAction(apiKey: String, actionId: Int, queue: dispatch_queue_t = dispatch_get_main_queue(), onCompletion: (Action?) -> Void, onError: (NSError?) -> Void) {
        Alamofire.request(ActionRouter.ReadAction(apiKey, actionId)).responseEvergreen { (response: Response<Action, NSError>) -> Void in
            if response.result.isSuccess {
                dispatch_async(queue) {
                    onCompletion(response.result.value)
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
     - parameter queue:        dispatch_queue_t to execute the handlers
     - parameter onCompletion: On success handler
     - parameter onError:      On error handler
     */
    public class func fetchActions(apiKey: String, queue: dispatch_queue_t = dispatch_get_main_queue(), onCompletion: ([Action]?) -> Void, onError: (NSError?) -> Void) {
        Alamofire.request(ActionRouter.ReadActions(apiKey)).responseEvergreen { (response: Response<[Action], NSError>) -> Void in
            if response.result.isSuccess {
                dispatch_async(queue) {
                    onCompletion(response.result.value)
                }
            } else {
                dispatch_async(queue) {
                    onError(response.result.error)
                }
            }
        }
    }
}