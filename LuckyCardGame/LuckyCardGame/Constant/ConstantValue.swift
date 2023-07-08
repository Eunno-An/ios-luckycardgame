//
//  ConstantValue.swift
//  LuckyCardGame
//
//  Created by Eunno An on 2023/07/06.
//

import Foundation
import UIKit

// TODO: enum에 대해서 좀 더 공통정보를 어떻게 정리하는게 좋을지 고민해보고, nested enum과 typealias를 고민해보자.
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
    static let height:CGFloat = CGFloat((Constant.screenHeight - Constant.topSpacing - Constant.topRectHeight - Constant.spacing - Constant.bottomSpacing) / 6.5) // board의 세로 길이
    static let width:CGFloat = CGFloat(Constant.screenWidth) - Constant.bottomSpacing // board의 가로 길이
    static let labels = ["A", "B", "C", "D", "E"] // board의 각 레이블
}
