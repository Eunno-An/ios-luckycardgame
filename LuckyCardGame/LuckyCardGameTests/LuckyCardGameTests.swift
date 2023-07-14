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
     */
    func testCanSortCardsASCbyCardNumber() throws{
        let cardsDummy:[LuckyCard] = [
            LuckyCard(number: .five, animal: .cat),
            LuckyCard(number: .three, animal: .cow),
            LuckyCard(number: .seven, animal: .dog),
            LuckyCard(number: .eight, animal: .cat),
            LuckyCard(number: .one, animal: .dog)
        ]
        
        var sut: Attendee = Attendee(deck: Deck(cards: cardsDummy))
        sut.sortDeckByNumberASC()
        let isArraySorted: Bool = isCardsSortedASC(cards: sut.deck.cards)
        
        XCTAssertTrue(isArraySorted, "카드를 오름차순으로 정렬할 수 없습니다.")
        
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
        
        var sut: Attendee = Attendee(deck: Deck(cards: cardsDummy))
        let result: Bool = sut.checkThreeNumbersAreInDeck()
        
        XCTAssertTrue(result, "세개의 숫자가 없습니다.")
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
        let sut: Attendee = Attendee(deck: Deck(cards: cardsDummy))
        
        let canFlipLeftMostCard: Bool = sut.canFlipLeftMostSideCard()
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
        let sut: Attendee = Attendee(deck: Deck(cards: cardsDummy))
        
        let canFlipLeftMostCard: Bool = sut.canFlipLeftMostSideCard()
        if canFlipLeftMostCard == false{
            let canFlipSecondLeftMostCard: Bool = sut.canFlipSecondLeftMostSideCard()
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
        let sut: Attendee = Attendee(deck: Deck(cards: cardsDummy))
        
        let canFlipLeftMostCard: Bool = sut.canFlipRightMostSideCard()
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
        let sut: Attendee = Attendee(deck: Deck(cards: cardsDummy))
        
        let canFlipLeftMostCard: Bool = sut.canFlipSecnodRightMostSideCard()
        if canFlipLeftMostCard == false{
            let canFlipSecondLeftMostCard: Bool = sut.canFlipSecnodRightMostSideCard()
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
        //given
        luckyCardGame.gameStart(attendeeNum: .three)
        let attendee_me = luckyCardGame.attendees[0]
        let attendee_theOther = luckyCardGame.attendees[1]
        attendee_me.choiceLeftSideCardOfTheOtherCard(cards: attendee_theOther.deck.cards, playerIdx: 1, luckyCardGame: luckyCardGame)
        attendee_me.choiceLeftSideCardOfTheOtherCard(cards: attendee_theOther.deck.cards, playerIdx: 1, luckyCardGame: luckyCardGame)
        attendee_me.choiceLeftSideCardOfTheOtherCard(cards: attendee_theOther.deck.cards, playerIdx: 1, luckyCardGame: luckyCardGame)
        
        //when
        let ret: Bool = attendee_me.canFlipLeftMostSideCard(temporaryChoicedCards: luckyCardGame.temporaryChoicedCards) && attendee_me.canFlipSecondLeftMostSideCard(temporaryChoicedCards: luckyCardGame.temporaryChoicedCards) && attendee_me.canFlipRightMostSideCard(temporaryChoicedCards: luckyCardGame.temporaryChoicedCards) && attendee_me.canFlipSecnodRightMostSideCard(temporaryChoicedCards: luckyCardGame.temporaryChoicedCards) && attendee_me.canFlipDownSideCard(card: luckyCardGame.belowLuckyCards[0], temporaryChoicedCards: luckyCardGame.temporaryChoicedCards)
        //then
        XCTAssertFalse(ret, "더 뒤집을 수 없습니다.")
    }

    func isCardsSortedASC(cards: [LuckyCard]) -> Bool{
        for cardIdx in 0..<cards.count-1{
            if cards[cardIdx].number.rawValue > cards[cardIdx].number.rawValue{
                return false
            }
        }
        return true
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
