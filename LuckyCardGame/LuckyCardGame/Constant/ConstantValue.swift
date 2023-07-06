//
//  ConstantValue.swift
//  LuckyCardGame
//
//  Created by Eunno An on 2023/07/06.
//

import Foundation

// MARK: 상수정보
enum Constant{
    static let topRectHeight:CGFloat = 44
    static let horizontalSpacing:CGFloat = 20
    static let topSpacing:CGFloat = 60
    static let bottomSpacing:CGFloat = 30
    static let spacing:CGFloat = 10
}

// MARK: Board의 공통 정보
enum Board{
    static let height:CGFloat = CGFloat(screenHeight / 8) // board의 세로 길이
    static let width:CGFloat = CGFloat(screenWidth) - Constant.bottomSpacing // board의 가로 길이
    static let labels = ["A", "B", "C", "D", "E"] // board의 각 레이블
}
