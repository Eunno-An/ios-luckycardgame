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
    
    //MARK: 덱의 가장 왼쪽에 있는 카드를 뒤집을 수 있는지 검사하는 카드입니다.
    func testTouchMostLeftCardWhenDownSide() throws{
        let cardsDummy: [LuckyCard] = [
            LuckyCard(number: .five, animal: .cat, isUpSide: false),
            LuckyCard(number: .three, animal: .cow),
            LuckyCard(number: .seven, animal: .dog),
            LuckyCard(number: .five, animal: .cat),
            LuckyCard(number: .five, animal: .dog)
        ]
        let realAttendee: Attendee = Attendee(deck: Deck(cards: cardsDummy))
        
        let canFlipLeftMostCard: Bool = realAttendee.canFlipLeftMostSideCard()
        XCTAssertTrue(canFlipLeftMostCard, "가장 왼쪽 카드를 뒤집을 수 없습니다.")
        //realAttendee.deck.cards[0].flipCard()
    }
    
    //MARK: 덱의 왼쪽에서 두번째 카드를 뒤집을 수 있는지 확인하는 테스트함수입니다.
    func testTouchSecondMostLeftCardWhenDownSide() throws{
        let cardsDummy: [LuckyCard] = [
            LuckyCard(number: .five, animal: .cat, isUpSide: true),
            LuckyCard(number: .three, animal: .cow, isUpSide: false),
            LuckyCard(number: .seven, animal: .dog),
            LuckyCard(number: .five, animal: .cat),
            LuckyCard(number: .five, animal: .dog)
        ]
        let realAttendee: Attendee = Attendee(deck: Deck(cards: cardsDummy))
        
        let canFlipLeftMostCard: Bool = realAttendee.canFlipLeftMostSideCard()
        if canFlipLeftMostCard == false{
            let canFlipSecondLeftMostCard: Bool = realAttendee.canFlipSecondLeftMostSideCard()
            XCTAssertTrue(canFlipSecondLeftMostCard, "왼쪽에서 두번재 카드를 뒤집을 수 없습니다.")
        }
        //realAttendee.deck.cards[1].flipCard()
    }
    
    //MARK: 덱의 가장 오른쪽 카드를 뒤집을 수 있는지 확인하는 테스트함수입니다.
    func testTouchMostRightCardWhenDownSide() throws{
        let cardsDummy: [LuckyCard] = [
            LuckyCard(number: .five, animal: .cat),
            LuckyCard(number: .three, animal: .cow),
            LuckyCard(number: .seven, animal: .dog),
            LuckyCard(number: .five, animal: .cat),
            LuckyCard(number: .five, animal: .dog, isUpSide: false)
        ]
        let realAttendee: Attendee = Attendee(deck: Deck(cards: cardsDummy))
        
        let canFlipLeftMostCard: Bool = realAttendee.canFlipRightMostSideCard()
        XCTAssertTrue(canFlipLeftMostCard, "가장 오른쪽 카드를 뒤집을 수 없습니다.")
        //realAttendee.deck.cards[0].flipCard()
    }
    
    //MARK: 덱의 오른쪽에서 두번째 카드를 뒤집을 수 있는지 확인하는 테스트함수입니다.
    func testTouchSecondMostRightCardWhenDownSide() throws{
        let cardsDummy: [LuckyCard] = [
            LuckyCard(number: .five, animal: .cat),
            LuckyCard(number: .three, animal: .cow),
            LuckyCard(number: .seven, animal: .dog),
            LuckyCard(number: .five, animal: .cat, isUpSide: false),
            LuckyCard(number: .five, animal: .dog, isUpSide: true)
        ]
        let realAttendee: Attendee = Attendee(deck: Deck(cards: cardsDummy))
        
        let canFlipLeftMostCard: Bool = realAttendee.canFlipSecnodRightMostSideCard()
        if canFlipLeftMostCard == false{
            let canFlipSecondLeftMostCard: Bool = realAttendee.canFlipSecnodRightMostSideCard()
            XCTAssertTrue(canFlipSecondLeftMostCard, "오른쪽에서 두번재 카드를 뒤집을 수 없습니다.")
        }
        //realAttendee.deck.cards[1].flipCard()
    }
    
    //MARK: 뒤집혀 있는 카드를 터치하면 앞면이 될 수 있는지 확인하는 테스트함수입니다.
    func testTouchBehindCardAndFlipCard() throws{
        
        var tempCard: LuckyCard = LuckyCard(number: .five, animal: .cat, isUpSide: true)
            
        tempCard.flipCard()
        
        XCTAssertFalse(tempCard.isSideFront, "카드가 뒷면에서 앞면으로 뒤집혀지지 않았습니다.")
        
    }
    
    //MARK: 사용자별로 총 세장의 카드만 뒤집을 수 있는지 확인하는 테스트함수입니다.
    func testPlayerShouldChooseOnlyThreeCards() throws{
        luckyCardGame.gameStart(attendeeNum: .three)
        
        let attendee_me = luckyCardGame.attendees[0]
        let attendee_theOther = luckyCardGame.attendees[1]
        
        //attendee_me.choice
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
