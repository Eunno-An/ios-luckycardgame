//
//  CardNumber.swift
//  LuckyCardGame
//
//  Created by Eunno An on 2023/07/06.
//

import Foundation

/*
 MARK: 코드의 가독성을 향상시키기 위해 Number의 enum을 사용했습니다.
 종류는 1~10의 10가지와 J,Q,K를 포함한 13가지입니다. 또한 enum을 collection화 하여 random하게 뽑기 위해 CaseIterable Protocol을 채택했습니다.
 Int로 한 이유는 추후에 대소비교를 쉽게 하기위함입니다.
 */
enum CardNumber: Int, CaseIterable{
    case one = 1
    case two
    case three
    case four
    case five
    case six
    case seven
    case eight
    case nine
    case ten
    case J
    case Q
    case K
}
