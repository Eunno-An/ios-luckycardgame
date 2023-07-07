//
//  Animal.swift
//  LuckyCardGame
//
//  Created by Eunno An on 2023/07/05.
//

import Foundation

/*
 MARK: 코드의 가독성을 향상시키기 위해 Animal의 enum을 사용했습니다. 종류는 Dog, Cat, Cow 세개입니다. 또한 enum을 collection화 하여 random하게 뽑기 위해 CaseIterable Protocol을 채택했습니다.
 */
enum Animal: String, CaseIterable{
    case dog = "\u{1F436}"
    case cat = "\u{1F431}"
    case cow = "\u{1F42E}"
}
