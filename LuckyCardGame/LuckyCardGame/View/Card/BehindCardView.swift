//
//  BehindCardView.swift
//  LuckyCardGame
//
//  Created by Eunno An on 2023/07/09.
//

import Foundation
import UIKit

class BehindCardView: CardView{
    typealias CardSize = Constant.CardConstant
    var imageView : UIImageView!
    
    init(frame: CGRect, imageView: UIImage = UIImage(named: "cardBackSideImage.png")!){
        super.init(frame: frame)
        self.imageView = UIImageView(image: imageView)
        self.imageView.frame = CGRect(x: CGFloat(CardSize.width - 20) / 2, y: CGFloat(CardSize.height - 20) / 2, width: 20, height: 20)
        addSubview(self.imageView)
        
    }
    
    required init?(coder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
}
