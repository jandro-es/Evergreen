//
//  EvergreenTests.swift
//  EvergreenTests
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

import XCTest
@testable import Evergreen

class EvergreenTests: XCTestCase {
    
    private let kApiTestToken = "Enter your Digital Ocean API token to test"
    
    var asyncExpectation: XCTestExpectation?
    
    func testReadAccount() {
        asyncExpectation = expectationWithDescription("Read Account expectation")
        Evergreen.fetchAccount(kApiTestToken, onCompletion: { (account) -> Void in
            if let realAccount = account {
                print(realAccount)
                self.asyncExpectation?.fulfill()
            }
            }) { (error) -> Void in
                if let error = error {
                    assertionFailure("Error while fetching account: \(error)")
                }
        }
        waitForExpectationsWithTimeout(5.0) { (error) -> Void in
            if error != nil {
                print("Error while waiting: \(error?.localizedDescription)")
            }
        }
    }
    
    func testReadActions() {
        asyncExpectation = expectationWithDescription("Read Actions expectation")
        Evergreen.fetchActions(kApiTestToken, onCompletion: { (actions) -> Void in
            if let actions = actions {
                print(actions)
                self.asyncExpectation?.fulfill()
            }
            }) { (error) -> Void in
                if let error = error {
                    assertionFailure("Error while fetching actions: \(error)")
                }
        }
        waitForExpectationsWithTimeout(5.0) { (error) -> Void in
            if error != nil {
                print("Error while waiting: \(error?.localizedDescription)")
            }
        }
    }
}
