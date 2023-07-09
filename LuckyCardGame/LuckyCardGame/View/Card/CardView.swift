//
//  CardView.swift
//  LuckyCardGame
//
//  Created by Eunno An on 2023/07/09.
//

import Foundation
import UIKit

class CardView: UIView{
    
    init(frame: CGRect, radius: Int = 16, borderWidth: Int = 1, backgroundColor: UIColor = .white){
        super.init(frame: frame)
        setRound(radius: radius)
        setBorderWidth(borderWidth: borderWidth)
        setBackgroundColor(backgroundColor: backgroundColor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setRound(radius: Int){
        self.layer.cornerRadius = CGFloat(radius)
        self.layer.masksToBounds = true
    }
    
    func setBorderWidth(borderWidth: Int){
        self.layer.borderWidth = CGFloat(borderWidth)
    }
    
    func setBackgroundColor(backgroundColor: UIColor){
        self.backgroundColor = backgroundColor
    }
    
}
