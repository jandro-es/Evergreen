//
//  EvergreenExtensionsTests.swift
//  Evergreen
//
//  Created by Alejandro Barros Cuetos on 04/02/2016.
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

import XCTest

class EvergreenExtensionsTests: XCTestCase {

    func testDateFromISO8601() {
        
        let dateString1 = "2014-11-14T16:29:21Z"
        let dateString2 = "2014-11-14T16:30:06Z"
        
        guard let date1 = NSDate(iso8601: dateString1), date2 = NSDate(iso8601: dateString2) else {
            XCTFail("Conversion from ISO8601 string to date failed")
            return
        }
        XCTAssert(date1.ISO8601() == dateString1 && date2.ISO8601() == dateString2)
    }
    
    func testGetQueryValues() {
        
        let urlString1 = "https://testurl.com/v2/path?page=159&per_page=1"
        let urlString2 = "https://testurl.com/v2/path?parameter1=2323&page=123&parameter2=2"
        
        guard let url1 = NSURL(string: urlString1), url2 = NSURL(string: urlString2) else {
            XCTFail("Conversion from String to NSURL failed")
            return
        }
        
        guard let parameter1 = url1.getQueryValues("page")?.first, parameter2 = url2.getQueryValues("page")?.first, parameter3 = url1.getQueryValues("per_page")?.first else {
            XCTFail("Error extracting parameter values")
            return
        }
        
        XCTAssert(parameter1 == "159" && parameter2 == "123" && parameter3 == "1")
    }
}
