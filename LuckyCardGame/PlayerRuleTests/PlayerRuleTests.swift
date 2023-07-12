//
//  PlayerRuleTests.swift
//  PlayerRuleTests
//
//  Created by Eunno An on 2023/07/12.
//

/*
 TODO: 규칙을 점검하기 위한 Model을 구현한다.
 TODO: 단위 테스트 코드로 게임의 규칙이 지켜지는지를 확인할 수 있어야한다.
 
 
 */
import XCTest
@testable import LuckyCardGame

final class PlayerRuleTests: XCTestCase {
    var luckyCardGame: TestingPlayerRuleMock!
    let attendeeNum: AttendeeNum = .three
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        try super.setUpWithError()
        luckyCardGame = TestingPlayerRuleMock()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        luckyCardGame = nil
    }
    
    /*
     MARK: 왼쪽카드를 뒤집는 테스트함수입니다.
     */
    func testTouchLeftMostDownSideCardInDeckOfPlayer() throws{
        let canFlipFirst: Bool = luckyCardGame.flipLeftMostSideCard()
        var canFlipSecond: Bool = false
        if canFlipFirst == false{//첫번째가 이미 뒤집혀져있을 경우
            canFlipSecond = luckyCardGame.flipLeftMostSideCard()
            XCTAssertTrue(canFlipSecond, "두번째 카드를 뒤집을 수 없습니다")
        }
    }
    
    /*
     MARK: 오른쪽카드를 뒤집는 테스트함수입니다.
     */
    func testTouchRightMostDownSizeCardInDeckOfPlayer() throws{
        let canFlipFirst: Bool = luckyCardGame.flipRightMostSideCard()
        var canFlipSecond: Bool = false
        if canFlipFirst == false{//첫번째가 이미 뒤집혀져있을 경우
            canFlipSecond = luckyCardGame.flipRightMostSideCard()
            XCTAssertTrue(canFlipSecond, "두번째 카드를 뒤집을 수 없습니다.")
        }
    }
    
    /*
     MARK: 뒤집혀 있는 카드를 터치하면 앞면이 보이도록 카드를 표시하는 테스트함수입니다.
     */
    func testTouchBehindCardAndFlipCard() throws{
        let isCardSideBehind: Bool = luckyCardGame.flipDownSideCard()
        XCTAssertTrue(isCardSideBehind, "이미 앞면이 보이는 카드입니다. 뒷면 카드를 선택해주세요")
    }
    
    /*
     MARK: 세장의 카드를 뒤집을 수 있는지 확인할 수 있는 테스트함수입니다.
     이 테스트케이스를 구현하기위해서는, 새로운 모델이 추가되어야 합니다.
     게임 결과를 각 turn마다 임시적으로 저장하는 
     */
    func testPlayerOnlyCanFlipThreeCards() throws{
        let canPlayersFlipOnlyThreeCards:Bool = luckyCardGame.areThreeCardsChoiced()
        XCTAssertTrue(canPlayersFlipOnlyThreeCards, "세장의 카드가 선택되어있지 않습니다.")
    }
    
    /*
     MARK: 세장의 카드 숫자가 같으면 표시화면에서 제거하고, 결과 화면으로 보내버리는 테스트함수입니다.
     */
    func testAllThreeCardsSameAndEliminateThenInGameViewAndMoveCardsToFinalResult() throws{
        let isAllCardsHaveThreeSameNumber:Bool = luckyCardGame.areThreeCardsNumberSame()
        XCTAssertTrue(isAllCardsHaveThreeSameNumber, "선택한 세개의 숫자들이 모두 같은 번호가 아닙니다!")
        
        let canEliminateCards: Bool = luckyCardGame.canEliminateCard()
        XCTAssertTrue(canEliminateCards, "모든 카드를 삭제할 수 없습니다.")
        
        let canSendTempResultToFinalResult: Bool = luckyCardGame.sendTempResultToFinalResult()
        XCTAssertTrue(canSendTempResultToFinalResult, "카드를 결과 화면으로 보낼 수 없습니다.")
    }

    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
