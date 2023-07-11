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
    
    func test_Cards_are_Split_Appripriately() throws{
        
        let attendees: [Attendee] = luckyCardGame.getAttendeesInfo()
        
        //각 attendee가 nil이 아닌지에 대한 검사
        for attendeeIdx in 0..<attendeeNum.rawValue{
            XCTAssertNotNil(attendees[attendeeIdx])
        }
        
        //각 attendee에게 맞는 장수만큼 분배되었는지에 대한 검사
        let playerShouldHaveCardsNum: AttendeeCardNum = AttendeeCardNum.getAttendeeCardNum(attendeeNum: attendeeNum)
        for attendeeIdx in 0..<attendeeNum.rawValue{
            let nowCardNum : Int = attendees[attendeeIdx].getDeck().getCards().count
            XCTAssertEqual(nowCardNum, playerShouldHaveCardsNum.rawValue, "카드 장수가 \(playerShouldHaveCardsNum)가 아니고 \(nowCardNum)장이네요, 분배가 제대로 이루어지지 않았습니다")
        }
        //전체 카드 풀이 랜덤한지를 검사
        let luckyCardPool : [LuckyCard] = luckyCardGame.getLuckyCardPool()
        
        var animalCountArr: [Int] = Array(repeating: 0, count: attendeeNum.rawValue)
        var numCountArr: [Int] = Array(repeating: 0, count: 12)
        
        
        for luckyCard in luckyCardPool{
            numCountArr[luckyCard.number.rawValue-1] += 1
            animalCountArr[Animal.getAnimalIdx(animal: luckyCard.animal)] += 1
        }
        
        var answerAnimalCountArr: [Int]
        var answerNumCountArr: [Int]
        
        if attendeeNum == .three{
            answerAnimalCountArr = Array(repeating: 11, count: attendeeNum.rawValue)
            answerNumCountArr = Array(repeating: attendeeNum.rawValue, count : 12)
            answerNumCountArr[answerNumCountArr.count-1] = 0
            
            XCTAssertEqual(animalCountArr, answerAnimalCountArr, "동물이 랜덤하게 배정되지 않았습니다.")
            XCTAssertEqual(numCountArr, answerNumCountArr, "숫자가 랜덤하게 배정되지 않았습니다.")
        }else{
            answerAnimalCountArr = Array(repeating: 12, count: attendeeNum.rawValue)
            answerNumCountArr = Array(repeating: attendeeNum.rawValue, count: 12)
            
            XCTAssertEqual(animalCountArr, answerAnimalCountArr, "동물이 랜덤하게 배정되지 않았습니다.")
            XCTAssertEqual(numCountArr, answerNumCountArr, "숫자가 랜덤하게 배정되지 않았습니다.")
        }
        
    }
    
    func test_PlayerCards_are_Sorted_by_CardNumber() throws{
        
        let attendees: [Attendee] = luckyCardGame.getAttendeesInfo()
        let deckSize: AttendeeCardNum = AttendeeCardNum.getAttendeeCardNum(attendeeNum: attendeeNum)
        
        
        for attendee in attendees {
            var isSortedASC = true
            let attendeeCards: [LuckyCard] = attendee.getDeck().getCards()
            for idx in 0..<deckSize.rawValue-1{
                if attendeeCards[idx].number.rawValue > attendeeCards[idx+1].number.rawValue{
                    isSortedASC =  false
                    break
                }
            }
            XCTAssertTrue(isSortedASC, "참가자의 카드 덱 오름차순 정렬기능에 문제가 있습니다.")
        }
    }
    
    func test_BelowCards_are_Sorted_by_CardNumber() throws{
        
        var isSortedASC: Bool = true
        let sortedLuckyCardArrSize: Int = luckyCardGame.getBelowLuckyCards().count
        let belowCards: [LuckyCard] = luckyCardGame.getBelowLuckyCards()
        
        for idx in 0..<sortedLuckyCardArrSize-1{
            if belowCards[idx].number.rawValue > belowCards[idx+1].number.rawValue{
                isSortedASC = false
                break
            }
        }
        
        XCTAssertTrue(isSortedASC, "바닥에 깔린 카드 덱 오름차순 정렬에 문제가 있습니다.")
        
    }
    
    func test_PlayerDeck_has_ThreeDuplicatedCardNumber() throws{
        let attendees:[Attendee] = luckyCardGame.getAttendeesInfo()
        
        var numCountArr: [Int] = Array(repeating: 0, count: 12)
        var isDeckHasThreeDupNum: Bool = false
        let attendeeNum : Int = attendees.count
        for attendeeIdx in 0..<attendeeNum{
            for card in attendees[attendeeIdx].getDeck().getCards(){
                numCountArr[card.number.rawValue] += 1
                if numCountArr[card.number.rawValue] == attendeeNum{
                    isDeckHasThreeDupNum = true
                    break
                }
            }
            XCTAssertFalse(isDeckHasThreeDupNum, "\(AttendeeName.getPlayerName(attendeeIdx: attendeeIdx)) 참가자가 같은 숫자 카드 \(attendeeNum)장을 가졌습니다.")
            isDeckHasThreeDupNum = false
            numCountArr = Array(repeating: 0, count: 12)
        }
    
    }
    
    /*
     이 테스트는 세개의 숫자가 같다는 조건만 검사합니다.
    추후의 조건은 Assert가 발생했을 때 처리해주는 로직을 따로 짜는게 훨씬 코드를 간결화 할 수 있을 것 같아서 이런 방식으로 진행했습니다.
     랜덤은 바텀 카드를 무작위로 고를 때만 사용했습니다.
     패를 고르는 상대는 "첫번째" 플레이어로 고정했습니다.
     */
    func test_SameThreeNumber_MinMaxVal_of_Deck_and_AnyCardInBottomDeck() throws{
        
        //만약 내꺼에서 두개가 연속으로 있다면?
        let myDeck: [LuckyCard] = luckyCardGame.get_xth_AttendeeInfo(attendeeIdx: 0) .getDeck().getCards()
        let otherDeck: [LuckyCard] = luckyCardGame.get_xth_AttendeeInfo(attendeeIdx: 1).getDeck().getCards()
        let bottomCards: [LuckyCard] = luckyCardGame.getBelowLuckyCards()
        
        if myDeck[0].number == myDeck[1].number{ //최솟값과 그 오른쪽 값이 같을 때
            //다른 참가자들을 랜덤하게 선택해서, 그 참가자의 최대, 최소를 랜덤하게 선택한다는 가정이지만, 뭔가 그냥 고정값으로 하자.
            if otherDeck[0].number == myDeck[0].number {
                XCTAssertEqual(otherDeck[0].number, otherDeck[1].number, "세개의 카드가 같습니다.")
            }else if otherDeck[otherDeck.count-1].number == myDeck[0].number{
                XCTAssertEqual(otherDeck[0].number, otherDeck[1].number, "세개의 카드가 같습니다.")
            }
        }else if myDeck[myDeck.count - 1].number == myDeck[myDeck.count-2].number{
            
            if otherDeck[otherDeck.count-1].number == myDeck[myDeck.count-1].number {
                XCTAssertEqual(otherDeck[0].number, otherDeck[1].number, "세개의 카드가 같습니다.")
            }else if otherDeck[0].number == myDeck[myDeck.count-1].number{
                XCTAssertEqual(otherDeck[0].number, otherDeck[1].number, "세개의 카드가 같습니다.")
            }
        }
        /*
         그렇지 않다면 가능성 두가지입니다. 1. 남에꺼에서 뽑고, 2. 바닥에서 뽑고.
         내 덱의 첫번째 패를 골랐을 때, 바닥에서 랜덤하게 카드를 선택합니다.
         */
        else if myDeck[0].number == otherDeck[0].number{
            
            XCTAssertEqual(myDeck[0].number, bottomCards[Int.random(in: 0...bottomCards.count-1)].number, "세개의 카드가 같습니다.")
        }else if myDeck[0].number == otherDeck[otherDeck.count-1].number{
            
            XCTAssertEqual(myDeck[0].number, bottomCards[Int.random(in: 0...bottomCards.count-1)].number, "세개의 카드가 같습니다.")
        }
        //내 덱의 마지막 패를 골랐을 때
        else if myDeck[myDeck.count-1].number == otherDeck[0].number{
            
            XCTAssertEqual(myDeck[myDeck.count-1].number, bottomCards[Int.random(in: 0...bottomCards.count-1)].number, "세개의 카드가 같습니다.")
        }else if myDeck[myDeck.count-1].number == otherDeck[otherDeck.count-1].number{
            
            XCTAssertEqual(myDeck[myDeck.count-1].number, bottomCards[Int.random(in: 0...bottomCards.count-1)].number, "세개의 카드가 같습니다.")
        }
    }
    
    
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
