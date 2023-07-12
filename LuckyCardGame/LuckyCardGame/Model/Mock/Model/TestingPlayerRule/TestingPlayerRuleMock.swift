//
//  TestingPlayerRuleMock.swift
//  LuckyCardGame
//
//  Created by Eunno An on 2023/07/12.
//

import Foundation

/*
 게임 진행을 위해서 다음과 같은 규칙을 구현한다
 - 정렬된 상태로 가장 작은 숫자가 있는 왼쪽 또는 가장 큰 숫자가 있는 오른쪽 카드만 터치가 가능하다. - 만약 가장 오른쪽 카드를 뒤집어서 앞면이 보이는 상태에서는 그 다음 숫자도 터치 가능하다 (한 번에 좌-우 중에 하나씩만 터치해서 뒤집기 가능)
 - 뒤집혀 있는 카드를 터치하면 앞면이 보이도록 카드를 표시한다
 - 사용자별로 총 3장의 카드만 뒤집을 수 있다
 - 만약 3장의 카드가 숫자가 같으면 표시 화면에서 제거하고, 결과 화면으로 보내버린다.
 - 게임이 끝나는 경우는 3장을 모은 카드 숫자 합 또는 차가 7이면 끝난다. 누군가 한 명이 7장을 모아도 끝나고, A와 B가 각각 1과 8을 모았어도 끝난다.
 */

class TestingPlayerRuleMock: LuckyCardGame{
    
    private var tempCardChoices: [TempSavedCardInfo] = []
    private var finalResult: FinalResult = FinalResult(attendeeNum: .three)//세명으로 고정합니다.
    
    //MARK: 가장 왼쪽에 있는 카드를 뒤집습니다.
    func flipLeftMostSideCard() -> Bool{
        return false
    }
    
    //MARK: 왼쪽에서 두번째 있는 카드를 뒤집습니다.
    func flipSecondLeftMostSideCard() -> Bool{
        return false
    }
    
    //MARK: 가장 오른쪽에 있는 카드를 뒤집습니다.
    func flipRightMostSideCard() -> Bool{
        return false
    }
    
    //MARK: 오른쪽에서 두번째 있는 카드를 뒤집습니다.
    func flipSecondRightMostSideCard() -> Bool{
        return false
    }
    
    //MARK: 아래로 뒤집혀져 있는 카드를 앞면이 보이도록 뒤집습니다.
    func flipDownSideCard() -> Bool{
        return false
    }
    
    //MARK: 현재 turn에 세장의 카드가 선택되어있는지를 검사합니다.
    func areThreeCardsChoiced() -> Bool{
        return false
    }
    
    //MARK: tempCardChoices에 저장된 숫자들이 다 같은지 검사합니다.
    func areThreeCardsNumberSame() -> Bool{
        return false
    }
    
    /*
     MARK: tempCardChoices를 순회하면서 해당 카드가 있었던 곳을 찾아가서 제거하고, tempCardChoices를 비웁니다.
     일단 모든 카드들을 지울 수 있는지에 대한 검사가 선행되어야합니다. 인덱스 접근은 지양합니다.
     마지막에는 tempCardChoices를 비워야합니다.
     */
    func canEliminateCard() -> Bool{
        return false
    }
    
    //MARK: 결과 화면으로 보내는 함수입니다.
    func sendTempResultToFinalResult() -> Bool{
        return false
    }
    
}
