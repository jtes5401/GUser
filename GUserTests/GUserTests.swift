//
//  GUserTests.swift
//  GUserTests
//
//  Created by Wei Kuo on 2020/2/21.
//  Copyright © 2020 Wei Kuo. All rights reserved.
//

import XCTest
@testable import GUser

class GUserTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGHUserDecoding() {
        let js = #"{"organizations_url":"https:\/\/api.github.com\/users\/mojombo\/orgs","repos_url":"https:\/\/api.github.com\/users\/mojombo\/repos","html_url":"https:\/\/github.com\/mojombo","site_admin":false,"gravatar_id":"","starred_url":"https:\/\/api.github.com\/users\/mojombo\/starred{\/owner}{\/repo}","avatar_url":"https://avatars0.githubusercontent.com/u/1?v=4","type":"User","gists_url":"https:\/\/api.github.com\/users\/mojombo\/gists{\/gist_id}","login":"mojombo","followers_url":"https:\/\/api.github.com\/users\/mojombo\/followers","id":1,"subscriptions_url":"https:\/\/api.github.com\/users\/mojombo\/subscriptions","following_url":"https:\/\/api.github.com\/users\/mojombo\/following{\/other_user}","received_events_url":"https:\/\/api.github.com\/users\/mojombo\/received_events","node_id":"MDQ6VXNlcjE=","url":"https:\/\/api.github.com\/users\/mojombo","events_url":"https:\/\/api.github.com\/users\/mojombo\/events{\/privacy}"}"#
        
        let decoder = JSONDecoder()
        
        if let data = js.data(using: .utf8) {
            
            do {
                let user = try decoder.decode(GHUser.self, from: data)
                XCTAssert(user.name == "mojombo", "name decoding fail")
                XCTAssert(user.picURL.absoluteString == "https://avatars0.githubusercontent.com/u/1?v=4", "picURL decoding fail")
                XCTAssert(user.isAdmin == false, "isAdmin decoding fail")

            } catch {
                print(error)
            }
        }
    }
    
    func testGHConnect() {
        let err = XCTestExpectation(description: "Download github users")
        let conn = GHConnecter()
        conn.requestUsers(since: 0, size: 2) { (users, result) in
            XCTAssert(result, "Load data fail")
            XCTAssert(users?.count == 2, "Load data size incorrect")
            err.fulfill()
        }
        wait(for: [err], timeout: 10.0)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
