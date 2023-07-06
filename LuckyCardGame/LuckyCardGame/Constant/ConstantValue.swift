//
//  ConstantValue.swift
//  LuckyCardGame
//
//  Created by Eunno An on 2023/07/06.
//

import Foundation
import UIKit

// MARK: 상수정보
enum Constant{
    
    // MARK: - 기기의 height, width
    static let screenHeight = UIScreen.main.bounds.height
    static let screenWidth = UIScreen.main.bounds.width
    
    static let topRectHeight:CGFloat = 44
    static let horizontalSpacing:CGFloat = 20
    static let topSpacing:CGFloat = 60
    static let bottomSpacing:CGFloat = 30
    static let spacing:CGFloat = 10
}

// MARK: Board의 공통 정보
enum Board{
    static let height:CGFloat = CGFloat(Constant.screenHeight / 8) // board의 세로 길이
    static let width:CGFloat = CGFloat(Constant.screenWidth) - Constant.bottomSpacing // board의 가로 길이
    static let labels = ["A", "B", "C", "D", "E"] // board의 각 레이블
}
