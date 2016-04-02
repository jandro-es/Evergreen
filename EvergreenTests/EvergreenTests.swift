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
    
    private let kApiTestToken = ""
    
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
                print("Page number 2 \n")
                Evergreen.fetchActions(self.kApiTestToken, page: 2, onCompletion: { (action) -> Void in
                    print(action)
                    self.asyncExpectation?.fulfill()
                    }, onError: { (error) -> Void in
                        if let error = error {
                            assertionFailure("Error while fetching second page of actions: \(error)")
                        }
                })
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
    
    func testReadDomains() {
        asyncExpectation = expectationWithDescription("Read Domains expectation")
        Evergreen.fetchDomains(kApiTestToken, onCompletion: { (domains) -> Void in
            if let domains = domains {
                print(domains)
                self.asyncExpectation?.fulfill()
            }
            }) { (error) -> Void in
                if let error = error {
                    assertionFailure("Error while fetching domains: \(error)")
                }
        }
        waitForExpectationsWithTimeout(5.0) { (error) -> Void in
            if error != nil {
                print("Error while waiting: \(error?.localizedDescription)")
            }
        }
    }
    
    /**
     Tests the creation of a domain, for it to work it needs a name and an IP Address for the domain
     */
    func testCreateDomain() {
        asyncExpectation = expectationWithDescription("Create Domain expectation")
        Evergreen.createDomain(kApiTestToken, values: ["name": "", "ip_address": ""], onCompletion: { (domain) -> Void in
            if let domain = domain {
                print(domain)
                self.asyncExpectation?.fulfill()
            }
            }) { (error) -> Void in
                if let error = error {
                    print(error)
                    assertionFailure("Error while creating domain: \(error)")
                }
        }
        waitForExpectationsWithTimeout(5.0) { (error) -> Void in
            if error != nil {
                print("Error while waiting: \(error?.localizedDescription)")
            }
        }
    }
    
    /**
     Test the deletion of a Domain, for it to work it needs the name of an existing domain
     */
    func testDeleteDomain() {
        asyncExpectation = expectationWithDescription("Delete Domain expectation")
        Evergreen.deleteDomain(kApiTestToken, domainName: "", onDeletionSuccess: {
            print("Deletion of the domain succesful")
            self.asyncExpectation?.fulfill()
            }) { (error) in
                if let error = error {
                    print(error)
                    assertionFailure("Error while deleting a domain: \(error)")
                }
        }
        waitForExpectationsWithTimeout(5.0) { (error) -> Void in
            if error != nil {
                print("Error while waiting: \(error?.localizedDescription)")
            }
        }
    }
}
