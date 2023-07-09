//
//  BehindCardView.swift
//  LuckyCardGame
//
//  Created by Eunno An on 2023/07/09.
//

import Foundation
import UIKit

class BehindCardView: CardView{
    var imageView : UIImage = UIImage(named: "cardBackSideImage.png")!
    
    init(frame: CGRect, imageView: UIImage){
        super.init(frame: frame)
        self.imageView = imageView
    }
    
    required init?(coder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
}
