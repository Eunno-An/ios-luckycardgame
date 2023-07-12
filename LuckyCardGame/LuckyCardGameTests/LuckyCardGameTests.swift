//
//  LuckyCardGameTests.swift
//  LuckyCardGameTests
//
//  Created by Eunno An on 2023/07/04.
//

import XCTest
@testable import LuckyCardGame

final class LuckyCardGameTests: XCTestCase {
    var luckyCardGame: Mock!
    let attendeeNum: AttendeeNum = .three
    
    override func setUpWithError() throws {
        
        try super.setUpWithError()
        luckyCardGame = Mock() // Dummy를 생성합니다.
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
     dummy를 mock으로 만들지 않고, stub으로 일부 필요한 객체만 만들어서 테스트를 진행했습니다.
     */
    func testCanSortCardsASCbyCardNumber() throws{
        let cardsDummy:[LuckyCard] = [
            LuckyCard(number: .five, animal: .cat),
            LuckyCard(number: .three, animal: .cow),
            LuckyCard(number: .seven, animal: .dog),
            LuckyCard(number: .eight, animal: .cat),
            LuckyCard(number: .one, animal: .dog)
        ]
        let canCardSortedASCByCardNumber: Bool = luckyCardGame.sortCardArrayASCByCardNumber(cards: cardsDummy)
        
        XCTAssertTrue(canCardSortedASCByCardNumber, "카드를 오름차순으로 정렬할 수 없습니다.")
        
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
        let areThreeNumbersAreSameInDeck: Bool = luckyCardGame.checkThreeNumbersAreInDeck(cards: cardsDummy, attendeeNum: .three)
        XCTAssertTrue(areThreeNumbersAreSameInDeck, "세개의 숫자가 없습니다.")
    }
    
    /*
     MARK: 내가 선택한 카드들이 똑같은지를 확인하는 테스트함수입니다.
     */
    func testThreeNumbersAreSameInMyChoice() throws{
        //스텁 생성
        let myCards: [LuckyCard] = [
            LuckyCard(number: .one, animal: .cat),
            LuckyCard(number: .two, animal: .cat),
            LuckyCard(number: .three, animal: .cat),
            LuckyCard(number: .four, animal: .cat),
            LuckyCard(number: .five, animal: .cat),
            LuckyCard(number: .six, animal: .cat),
            LuckyCard(number: .seven, animal: .cat),
            LuckyCard(number: .eight, animal: .cat)
        ]
        let theOtherPlayerCards: [LuckyCard] = [
            LuckyCard(number: .one, animal: .cow),
            LuckyCard(number: .two, animal: .cow),
            LuckyCard(number: .three, animal: .cow),
            LuckyCard(number: .four, animal: .cow),
            LuckyCard(number: .five, animal: .cow),
            LuckyCard(number: .six, animal: .cow),
            LuckyCard(number: .seven, animal: .cow),
            LuckyCard(number: .eight, animal: .cow)
            ]
        let bottomCards: [LuckyCard] = [
            LuckyCard(number: .one, animal: .dog),
            LuckyCard(number: .two, animal: .dog),
            LuckyCard(number: .three, animal: .dog),
            LuckyCard(number: .four, animal: .dog),
            LuckyCard(number: .five, animal: .dog),
            LuckyCard(number: .six, animal: .dog),
            LuckyCard(number: .seven, animal: .dog),
            LuckyCard(number: .eight, animal: .dog),
            LuckyCard(number: .nine, animal: .dog)
        ]
        
        let areThreeNumbersAreSameBetween: Bool = luckyCardGame.checkThreeNumbersAreSame(card1: myCards[0], card2: theOtherPlayerCards[0], card3: bottomCards[0])
        
        XCTAssertTrue(areThreeNumbersAreSameBetween, "세개의 숫자가 같지 않습니다.")
        
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
