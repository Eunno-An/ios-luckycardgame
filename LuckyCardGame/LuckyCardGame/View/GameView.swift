//
//  GameView.swift
//  LuckyCardGame
//
//  Created by Eunno An on 2023/07/07.
//

import Foundation
import UIKit

class GameView: UIView{
    var luckyCardGame: LuckyCardGame
    init(){
        luckyCardGame = LuckyCardGame()
        super.init(frame: CGRect(x: (CGFloat(Constant.horizontalSpacing)),
                                 y : (Constant.topSpacing + Constant.topRectHeight + Constant.spacing),
                                 width: (CGFloat(Int(Constant.screenWidth)) - CGFloat(Constant.horizontalSpacing * 2)), height: (Constant.screenHeight) - (Constant.topSpacing + Constant.topRectHeight + Constant.spacing)))
    }
    
    init(luckyCardGame: LuckyCardGame){
        self.luckyCardGame = luckyCardGame
        super.init(frame: CGRect(x: (CGFloat(Constant.horizontalSpacing)),
                                 y : (Constant.topSpacing + Constant.topRectHeight + Constant.spacing),
                                 width: (CGFloat(Int(Constant.screenWidth)) - CGFloat(Constant.horizontalSpacing * 2)), height: (Constant.screenHeight) - (Constant.topSpacing + Constant.topRectHeight + Constant.spacing)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
