//
//  LuckyCardGameTests.swift
//  LuckyCardGameTests
//
//  Created by Eunno An on 2023/07/04.
//

import XCTest
@testable import LuckyCardGame

final class LuckyCardGameTests: XCTestCase {
    var luckyCardGame: LuckyCardGame!
    let attendeeNum: AttendeeNum = .three
    override func setUp() async throws {
        try await super.setUp()
        
        luckyCardGame = LuckyCardGame()
        luckyCardGame.gameStart(attendeeNum: attendeeNum)
        for attendee in luckyCardGame.getAttendeesInfo(){
            attendee.sortDeckByNumberASC()
        }
        luckyCardGame.sortBelowLuckyCards_by_CardNumber()
        
    }
    
    override func setUpWithError() throws {
        
    }
    
    override func tearDownWithError() throws {
        
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        luckyCardGame = nil
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
