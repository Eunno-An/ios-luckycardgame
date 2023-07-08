//
//  PlayerZoneView.swift
//  LuckyCardGame
//
//  Created by Eunno An on 2023/07/08.
//

import Foundation
import UIKit

class PlayerZoneView: UIView{
    
    private var playerBoardViews: [PlayerboardView] = {
        var views: [PlayerboardView] = []
        for i in 1...AttendeeNum.three.rawValue{
            views.append(PlayerboardView(frame:
                                            CGRect(x: (CGFloat(Constant.horizontalSpacing)),
                                                y: Constant.topSpacing + Constant.topRectHeight + Constant.spacing * CGFloat(i+1) + Board.height * CGFloat(i),
                                                   width: CGFloat(Constant.screenWidth) - CGFloat(Constant.horizontalSpacing * 2),
                                                   height: Board.height), name: Board.labels[i-1]))
        }
        return views
    }()
    
    init(){
        super.init(frame: CGRect(x: Constant.horizontalSpacing, y: Constant.topSpacing + Constant.topRectHeight + Constant.spacing, width: Constant.screenWidth - Constant.horizontalSpacing * 2, height: (Board.height + Constant.spacing) * CGFloat(AttendeeNum.four.rawValue)))
        
        for playerBoardIdx in 0..<AttendeeNum.three.rawValue{
            self.addSubview(playerBoardViews[playerBoardIdx])
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
