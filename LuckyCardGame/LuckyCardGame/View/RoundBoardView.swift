//
//  RoundBoardView.swift
//  LuckyCardGame
//
//  Created by Eunno An on 2023/07/04.
//

import UIKit

class RoundBoardView: UIView{
    
    init(frame: CGRect, radius: Int = 16){
        super.init(frame: frame)
        setRound(radius: radius)
    }
    
    required init?(coder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
    func setRound(radius: Int){
        self.layer.cornerRadius = CGFloat(radius)
        self.layer.masksToBounds = true
    }
    
}
