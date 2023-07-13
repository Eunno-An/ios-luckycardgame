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
    
    override func setUpWithError() throws {
        
        try super.setUpWithError()
        luckyCardGame = LuckyCardGame() // Dummy를 생성합니다.
    }
    
    override func tearDownWithError() throws {
        
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        luckyCardGame = nil
    }
    
    /*
     MARK: 카드가 적절하게 split됐는지를 확인하는 테스트함수입니다.
     전체 카드의 숫자 개수와 symbol 개수를 체크합니다.
     */
    func testCardsAreSplitAppropriately() throws{
        luckyCardGame.gameStart(attendeeNum: .three)//dummy를 mock으로 변경합니다.
        let numberCheckingFlag: Bool = luckyCardGame.checkAllNumbersInCards(attendeeNum: .three)
        XCTAssertTrue(numberCheckingFlag, "카드의 숫자가 잘못 분배되어있습니다.")
        
        let symbolCheckingFlag: Bool = luckyCardGame.checkAllSymbolsInCards(attendeeNum: .three)
        XCTAssertTrue(symbolCheckingFlag, "카드의 동물이 잘못 분배되어있습니다.")
        
    }
    
    /*
     MARK: 카드를 오름차순으로 정렬할 수 있는지를 확인하는 테스트함수입니다.
     stub으로 일부 필요한 객체만 만들어서 테스트를 진행했습니다.
     */
    func testCanSortCardsASCbyCardNumber() throws{
        let cardsDummy:[LuckyCard] = [
            LuckyCard(number: .five, animal: .cat),
            LuckyCard(number: .three, animal: .cow),
            LuckyCard(number: .seven, animal: .dog),
            LuckyCard(number: .eight, animal: .cat),
            LuckyCard(number: .one, animal: .dog)
        ]
        
        var mockPlayer: MockPlayer = MockPlayer(cards: cardsDummy)
        mockPlayer.sortDeckByNumberASC()
        
        var realAttendee: Attendee = Attendee(deck: Deck(cards: cardsDummy))
        realAttendee.sortDeckByNumberASC()
        
        print(mockPlayer.cards.count)
        print(realAttendee.deck.cards.count)
        XCTAssertEqual(realAttendee.deck.cards, mockPlayer.cards,"카드를 오름차순으로 정렬할 수 없습니다.")
        
    }
    
    /*
     MARK: 덱에 있는 카드 중, 같은 숫자 세개가 있는지 확인하는 테스트함수입니다.
     */
    func testThreeNumbersAreSameInDeck() throws{
        //스텁 생성
        let cardsDummy: [LuckyCard] = [
            LuckyCard(number: .five, animal: .cat),
            LuckyCard(number: .three, animal: .cow),
            LuckyCard(number: .seven, animal: .dog),
            LuckyCard(number: .five, animal: .cat),
            LuckyCard(number: .five, animal: .dog)
        ]
        
        var mockPlayer: MockPlayer = MockPlayer(cards: cardsDummy)
        let resultOfMock: Bool = mockPlayer.checkThreeNumbersAreInDeck()
        
        var realAttendee: Attendee = Attendee(deck: Deck(cards: cardsDummy))
        let resultOfReal: Bool = realAttendee.checkThreeNumbersAreInDeck()
        
        XCTAssertEqual(resultOfMock, resultOfReal, "세개의 숫자가 없습니다.")
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
