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
        
        var cardsDummy:[LuckyCard] = [
            LuckyCard(number: .five, animal: .cat),
            LuckyCard(number: .three, animal: .cow),
            LuckyCard(number: .seven, animal: .dog),
            LuckyCard(number: .eight, animal: .cat),
            LuckyCard(number: .one, animal: .dog)
        ]
        
        let sut: Attendee = Attendee(deck: Deck(cards: cardsDummy))
        
        sut.sortDeckByNumberASC()
    
        var flag: Bool = false
        for cardIdx in 0..<sut.deck.cards.count-1{
            if sut.deck.cards[cardIdx].number.rawValue > sut.deck.cards[cardIdx+1].number.rawValue{
                flag = true
                XCTAssertFalse(flag, "카드를 오름차순으로 정렬할 수 없습니다.")
                break
                
            }
        }
        
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
    
    //MARK: 덱의 가장 왼쪽에 있는 카드를 뒤집을 수 있는지 검사하는 테스트입니다.
    func testTouchMostLeftCardWhenDownSide() throws{
        //given
        let cardsDummy: [LuckyCard] = [
            LuckyCard(number: .five, animal: .cat, isUpSide: false),
            LuckyCard(number: .three, animal: .cow),
            LuckyCard(number: .seven, animal: .dog),
            LuckyCard(number: .five, animal: .cat),
            LuckyCard(number: .five, animal: .dog)
        ]
        
        let sut: Attendee = Attendee(deck: Deck(cards: cardsDummy))
        
        //when
        //어떤 turn에 두 장의 카드 번호가 같은걸 뽑았을 경우
        let temporaryChoicedCardsWithSizeTwo : [TempChoicedCardInfo] = [
            TempChoicedCardInfo(cardIdx: 0, isBottomCardOrPlayerCard: true, playerIdx: 0, card: LuckyCard(number: .five, animal: .cat, isUpSide: true)),
            TempChoicedCardInfo(cardIdx: 0, isBottomCardOrPlayerCard: true, playerIdx: 0, card: LuckyCard(number: .five, animal: .dog, isUpSide: true))
        ]
        
        //어떤 turn에 이미 세장의 같은 숫자 카드를 뽑았을 경우
        let temporaryChoicedCardsWidthSizeThree : [TempChoicedCardInfo] = [
            TempChoicedCardInfo(cardIdx: 0, isBottomCardOrPlayerCard: true, playerIdx: 0, card: LuckyCard(number: .five, animal: .cat, isUpSide: true)),
            TempChoicedCardInfo(cardIdx: 0, isBottomCardOrPlayerCard: true, playerIdx: 0, card: LuckyCard(number: .five, animal: .dog, isUpSide: true)),
            TempChoicedCardInfo(cardIdx: 0, isBottomCardOrPlayerCard: true, playerIdx: 0, card: LuckyCard(number: .five, animal: .cow, isUpSide: true))
        ]
        
        //then
        var canFlipLeftMostCard: Bool = sut.canFlipLeftMostSideCard(temporaryChoicedCards: temporaryChoicedCardsWithSizeTwo)
        XCTAssertTrue(canFlipLeftMostCard, "가장 왼쪽 카드를 뒤집을 수 없습니다.")
        
        canFlipLeftMostCard = sut.canFlipLeftMostSideCard(temporaryChoicedCards: temporaryChoicedCardsWidthSizeThree)
        XCTAssertFalse(canFlipLeftMostCard, "이미 선택한 카드가 세개라서 뒤집을 수 없습니다.")
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
        
        
        //어떤 turn에 두 장의 카드 번호가 같은걸 뽑았을 경우
        let temporaryChoicedCardsWithSizeTwo : [TempChoicedCardInfo] = [
            TempChoicedCardInfo(cardIdx: 0, isBottomCardOrPlayerCard: true, playerIdx: 0, card: LuckyCard(number: .five, animal: .cat, isUpSide: true)),
            TempChoicedCardInfo(cardIdx: 0, isBottomCardOrPlayerCard: true, playerIdx: 0, card: LuckyCard(number: .five, animal: .dog, isUpSide: true))
        ]
        
        //어떤 turn에 이미 세장의 같은 숫자 카드를 뽑았을 경우
        let temporaryChoicedCardsWidthSizeThree : [TempChoicedCardInfo] = [
            TempChoicedCardInfo(cardIdx: 0, isBottomCardOrPlayerCard: true, playerIdx: 0, card: LuckyCard(number: .five, animal: .cat, isUpSide: true)),
            TempChoicedCardInfo(cardIdx: 0, isBottomCardOrPlayerCard: true, playerIdx: 0, card: LuckyCard(number: .five, animal: .dog, isUpSide: true)),
            TempChoicedCardInfo(cardIdx: 0, isBottomCardOrPlayerCard: true, playerIdx: 0, card: LuckyCard(number: .five, animal: .cow, isUpSide: true))
        ]
        //when
        var canFlipRightMostCard: Bool = sut.canFlipRightMostSideCard(temporaryChoicedCards: temporaryChoicedCardsWithSizeTwo)
        
        //then
        XCTAssertTrue(canFlipRightMostCard, "가장 왼쪽 카드를 뒤집을 수 없습니다.")
        
        canFlipRightMostCard = sut.canFlipRightMostSideCard(temporaryChoicedCards: temporaryChoicedCardsWidthSizeThree)
        XCTAssertFalse(canFlipRightMostCard, "이미 선택한 카드가 세개라서 뒤집을 수 없습니다.")
    }
    
    //MARK: 덱의 가장 오른쪽 카드를 뒤집을 수 있는지 확인하는 테스트함수입니다.
    func testTouchMostRightCardWhenDownSide() throws{
        //given
        let cardsDummy: [LuckyCard] = [
            LuckyCard(number: .five, animal: .cat),
            LuckyCard(number: .three, animal: .cow),
            LuckyCard(number: .seven, animal: .dog),
            LuckyCard(number: .five, animal: .cat),
            LuckyCard(number: .five, animal: .dog, isUpSide: false)
        ]
        let sut: Attendee = Attendee(deck: Deck(cards: cardsDummy))
        
        //어떤 turn에 두 장의 카드 번호가 같은걸 뽑았을 경우
        let temporaryChoicedCardsWithSizeTwo : [TempChoicedCardInfo] = [
            TempChoicedCardInfo(cardIdx: 0, isBottomCardOrPlayerCard: true, playerIdx: 0, card: LuckyCard(number: .five, animal: .cat, isUpSide: true)),
            TempChoicedCardInfo(cardIdx: 0, isBottomCardOrPlayerCard: true, playerIdx: 0, card: LuckyCard(number: .five, animal: .dog, isUpSide: true))
        ]
        
        //어떤 turn에 이미 세장의 같은 숫자 카드를 뽑았을 경우
        let temporaryChoicedCardsWidthSizeThree : [TempChoicedCardInfo] = [
            TempChoicedCardInfo(cardIdx: 0, isBottomCardOrPlayerCard: true, playerIdx: 0, card: LuckyCard(number: .five, animal: .cat, isUpSide: true)),
            TempChoicedCardInfo(cardIdx: 0, isBottomCardOrPlayerCard: true, playerIdx: 0, card: LuckyCard(number: .five, animal: .dog, isUpSide: true)),
            TempChoicedCardInfo(cardIdx: 0, isBottomCardOrPlayerCard: true, playerIdx: 0, card: LuckyCard(number: .five, animal: .cow, isUpSide: true))
        ]
        //when
        var canFlipRightMostCard: Bool = sut.canFlipRightMostSideCard(temporaryChoicedCards: temporaryChoicedCardsWithSizeTwo)
        
        //then
        XCTAssertTrue(canFlipRightMostCard, "가장 왼쪽 카드를 뒤집을 수 없습니다.")
        
        //when
        canFlipRightMostCard = sut.canFlipRightMostSideCard(temporaryChoicedCards: temporaryChoicedCardsWidthSizeThree)
        //then
        XCTAssertFalse(canFlipRightMostCard, "이미 선택한 카드가 세개라서 뒤집을 수 없습니다.")
        
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
        
        let canFlipLeftMostCard: Bool = sut.canFlipSecnodRightMostSideCard(temporaryChoicedCards: luckyCardGame.temporaryChoicedCards)
        if canFlipLeftMostCard == false{
            let canFlipSecondLeftMostCard: Bool = sut.canFlipSecnodRightMostSideCard(temporaryChoicedCards: luckyCardGame.temporaryChoicedCards)
            XCTAssertTrue(canFlipSecondLeftMostCard, "오른쪽에서 두번재 카드를 뒤집을 수 없습니다.")
        }
        //realAttendee.deck.cards[1].flipCard()
    }
    
    //MARK: 뒤집혀 있는 카드를 터치하면 앞면이 될 수 있는지 확인하는 테스트함수입니다.
    func testTouchBehindCardAndFlipCard() throws{
        
        let tempCard: LuckyCard = LuckyCard(number: .five, animal: .cat, isUpSide: true)
            
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

    //MARK: 만약 세장의 카드가 숫자가 같으면 표시 화면에서 제거하고, 결과 화면으로 보내버리는지를 테스트하는 함수입니다.
    func testAllThreeNumbersSameThenEliminateThenAndSendFinalResult(){
        //given
        luckyCardGame.gameStart(attendeeNum: .three)
        let attendee_me = luckyCardGame.attendees[0]
        let attendee_theOther = luckyCardGame.attendees[1]
        attendee_me.choiceLeftSideCardOfTheOtherCard(cards: attendee_theOther.deck.cards, playerIdx: 1, luckyCardGame: luckyCardGame)
        attendee_me.choiceLeftSideCardOfTheOtherCard(cards: attendee_theOther.deck.cards, playerIdx: 1, luckyCardGame: luckyCardGame)
        attendee_me.choiceLeftSideCardOfTheOtherCard(cards: attendee_theOther.deck.cards, playerIdx: 1, luckyCardGame: luckyCardGame)
        //when
        let ret: Bool =   luckyCardGame.checkThreeCardsInTemporaryChoiceCards()
        //then
        XCTAssertTrue(ret, "세장의 카드를 아직 선택하지 않았습니다.")
        
        //when
        let ret2: Bool = luckyCardGame.checkThreeNumbersInTemporaryChoicedCardsAreSameNumber()
        //then
        XCTAssertTrue(ret2, "세장의 카드 숫자가 같지않습니다.")
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
