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
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        luckyCardGame = LuckyCardGame()
        luckyCardGame.gameStart(attendeeNum: .three)
        do {
            
            try testAppropriateSplit(attendeeNum: .three) // 참가자수를 지정하고 게임을 초기화하면 적절하게 카드를 나눠줘야 한다
            
            printGameInfoBefore_Or_AfterTest(attendeeNum: .three)
            //try testPlayerCardIsSortedAscending(attendeeIdx: 0) // 참가자별로 카드를 숫자 오름차순으로 정렬할 수 있어야 한다
            //try testPlayerCardIsSortedDescending(attendeeIdx: 0)
            //try testBottomCardIsSortedAscending(bottomLuckyCards: luckyCardGame.getBelowLuckyCards()) // 바닥에 깔린 카드도 숫자 오름차순으로 정렬할 수 있어야 한다
            //try testBottomCardIsSortedDescending(bottomLuckyCards: luckyCardGame.getBelowLuckyCards()) // 참가자 중에 같은 숫자 카드 3장을 가진 경우가 있는지 판단할 수 있다
            //try testPlayerDeckHasThreeDuplicatedNum(attendees: luckyCardGame.getAttendeesInfo()) // 특정 참가자와 해당 참가자 카드 중에 가장 낮은 숫자 또는 가장 높은 숫자, 바닥 카드 중 아무거나를 선택해서 3개가 같은지 판단할 수 있어야 한다.
            
            try testSameThreeNumber_MinMaxVal_of_Deck_and_AnyCardInBottomDeck(attendee: luckyCardGame.getMyInfo(), bottomCards: luckyCardGame.getBelowLuckyCards())
            //printGameInfoBefore_Or_AfterTest(attendeeNum: .three)
            
            
            
            
            
        } catch{
            
        }
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        luckyCardGame = nil
    }

    
    //참가자 수가 주어지면, 참가자들의 [card]정보를 출력하는 함수
    func printAttendeesDeckInfo(attendeeNum: AttendeeNum){
        let attendeeNames: [String] = AttendeeNum.getPlayerNames(attendeeNum: attendeeNum)
        
        for attendeeIdx in 0..<attendeeNum.rawValue{
            print(attendeeNames[attendeeIdx], terminator: " ")
            printPlayerCardsInfo(cards: luckyCardGame.getAttendeesInfo()[attendeeIdx].getDeck().getCards())
        }
    }
    
    //바닥의 [card]정보를 출력하는 함수
    func printBottomCardsInfo(attendeeNum: AttendeeNum){
        print("바닥 [", terminator: "")
        let bottomCardSize: Int = luckyCardGame.getBelowLuckyCards().count
        for bottomCardIdx in 0..<bottomCardSize{
            print(luckyCardGame.getBelowLuckyCards()[bottomCardIdx].describe, terminator: "")
            if bottomCardIdx != bottomCardSize - 1{
                print(",", terminator: "")
            }
        }
        print("]")
    }
    
    //테스트 전의 덱 정보를 출력하는 함수
    func printGameInfoBefore_Or_AfterTest(attendeeNum: AttendeeNum){
        printAttendeesDeckInfo(attendeeNum: attendeeNum)
        printBottomCardsInfo(attendeeNum: attendeeNum)
    }
    
    //주어진 [card]를 출력하는 함수
    func printPlayerCardsInfo(cards: [LuckyCard]){
        print("[", terminator: "")
        let cardSize = cards.count
        for cardIdx in 0..<cardSize {
            print(cards[cardIdx].describe, terminator: "")
            if cardIdx != cardSize - 1{
                print(", ", terminator: "")
            }
        }
        print("]")
    }
    
    
    /*
     카드를 적절하게 섞었는지 확인하는 함수입니다.
     1. 카드가 모든 참가자에게 같은 숫자만큼 분배되었는지 확인합니다.
     2. 전체 카드 풀이 모든 경우를 포함하는지 확인합니다.
        2-1. 참가자가 세명일 때는 12가 없다는 사실을 고려해야합니다.
        2-2. 그 외에는 카드가 종류별로 참가자 수만큼 나와야합니다.
        2-3. 동물도 종류별로 나오는지 확인합니다.
     */
    func testAppropriateSplit(attendeeNum: AttendeeNum) throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        
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

    //참가자의 카드를 오름차순으로 정렬할 수 있는지 확인합니다.
    func testPlayerCardIsSortedAscending(attendeeIdx: Int) throws{
        let luckyCards: [LuckyCard] = luckyCardGame.getAttendeesInfo()[attendeeIdx].getDeck().getCards()
        let sortedLuckyCards: [LuckyCard] = luckyCards.sorted {
            $0.number.rawValue < $1.number.rawValue
        }
        
        var isSortedASC: Bool = true
        let sortedLuckyCardArrSize: Int = sortedLuckyCards.count
        
        for i in 0..<sortedLuckyCardArrSize-1{
            if sortedLuckyCards[i].number.rawValue > sortedLuckyCards[i+1].number.rawValue{
                isSortedASC = false
                break
            }
        }
        
        XCTAssertTrue(isSortedASC, "참가자의 카드 덱 오름차순 정렬기능에 문제가 있습니다.")
        
        luckyCardGame.set_xth_AttendeeCardInfo(attendeeIdx: attendeeIdx, deck: Deck(cards: sortedLuckyCards))
    }
    
    //참가자의 카드를 내림차순으로 정렬할 수 있는지 확인합니다.
    func testPlayerCardIsSortedDescending(attendeeIdx: Int) throws{
        let luckyCards: [LuckyCard] = luckyCardGame.getAttendeesInfo()[attendeeIdx].getDeck().getCards()
        let sortedLuckyCards: [LuckyCard] = luckyCards.sorted{
            $0.number.rawValue > $1.number.rawValue
        }
        
        var isSortedDESC: Bool = true
        let sortedLuckyCardArrSize: Int = sortedLuckyCards.count
        
        for i in 0..<sortedLuckyCardArrSize-1{
            if sortedLuckyCards[i].number.rawValue < sortedLuckyCards[i+1].number.rawValue{
                isSortedDESC = false
                break
            }
        }
        
        XCTAssertTrue(isSortedDESC, "참가자의 카드 덱 내림차순 정렬기능에 문제가 있습니다.")
        
        luckyCardGame.set_xth_AttendeeCardInfo(attendeeIdx: attendeeIdx, deck: Deck(cards: sortedLuckyCards))
    }

    //바닥에 있는 카드를 오름차순으로 정렬할 수 있는지 확인합니다.
    func testBottomCardIsSortedAscending(bottomLuckyCards: [LuckyCard]) throws{
        let sortedLuckyCards: [LuckyCard] = bottomLuckyCards.sorted{
            $0.number.rawValue < $1.number.rawValue
        }
        
        var isSortedASC: Bool = true
        let sortedLuckyCardArrSize: Int = sortedLuckyCards.count
        
        for i in 0..<sortedLuckyCardArrSize-1{
            if sortedLuckyCards[i].number.rawValue > sortedLuckyCards[i].number.rawValue{
                isSortedASC = false
                break
            }
        }
        
        XCTAssertTrue(isSortedASC, "바닥에 깔린 카드 덱 오름차순 정렬에 문제가 있습니다.")
        
        luckyCardGame.setBelowLuckyCards(belowLuckyCards: sortedLuckyCards)
    }
    
    //바닥에 있는 카드를 내림차순으로 정렬할 수 있는지 확인합니다.
    func testBottomCardIsSortedDescending(bottomLuckyCards: [LuckyCard]) throws{
        let sortedLuckyCards: [LuckyCard] = bottomLuckyCards.sorted{
            $0.number.rawValue > $1.number.rawValue
        }
        
        var isSortedDESC: Bool = true
        let sortedLuckyCardArrSize: Int = sortedLuckyCards.count
        
        for i in 0..<(sortedLuckyCardArrSize-1){
            if sortedLuckyCards[i].number.rawValue < sortedLuckyCards[i+1].number.rawValue{
                isSortedDESC = false
                break
            }
        }
        
        XCTAssertTrue(isSortedDESC, "바닥에 깔린 카드 덱 내림차순 정렬에 문제가 있습니다.")
        
        luckyCardGame.setBelowLuckyCards(belowLuckyCards: sortedLuckyCards)
    }
    
    //참가자의 덱에 같은 숫자 세개가 있는지 확인합니다.
    func testPlayerDeckHasThreeDuplicatedNum(attendees: [Attendee]) throws{
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
     참가자의 카드 숫자 최댓값과 최솟값이 같은지 확인하고, 같다면 이 숫자가 bottomCards에 있는지 확인합니다.
     카드 숫자의 최댓값과 최솟값이 다르면 Assert되고, 만약 같다면 이 숫자가 bottomCards에 없으면 Assert합니다.
     */
    func testSameThreeNumber_MinMaxVal_of_Deck_and_AnyCardInBottomDeck(attendee: Attendee, bottomCards: [LuckyCard]) throws{
        let sortedLuckyCards: [LuckyCard] = attendee.getDeck().getCards().sorted{
            $0.number.rawValue > $1.number.rawValue
        }
        let isMinMaxValSame: Bool = (sortedLuckyCards.first?.number == sortedLuckyCards.last?.number)
        
        XCTAssertTrue(isMinMaxValSame, "플레이어 덱의 가장 낮은 숫자와 가장 높은 숫자가 서로 다릅니다!")
        
        let is_BottomCards_contains_MinMaxVal_of_LuckyCardArray: Bool = bottomCards.map{$0.number.rawValue}.contains(sortedLuckyCards[0].number.rawValue)
        
        XCTAssertTrue(is_BottomCards_contains_MinMaxVal_of_LuckyCardArray, "바닥 카드에는 플레이어 덱의 가장 낮은 숫자(혹은 가장 높은 숫자)와 일치하는 숫자가 없습니다!")
    }
    
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
