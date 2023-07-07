//
//  SegmentedControlView.swift
//  LuckyCardGame
//
//  Created by Eunno An on 2023/07/06.
//

import Foundation
import UIKit

/*
 MARK: 상단의 SegmentedControlView 구현체입니다.
 UIView를 상속받았으며, 현재 frame을 기존의 노란색 블록의 fame으로 대체합니다.
 */
class SegmentedControlView: UIView{
    private let uiSegmentControlView = UISegmentedControl(items: ["3명", "4명", "5명"])
    init(){
        super.init(frame: CGRect(x: (CGFloat(Constant.horizontalSpacing)),
                                 y : Constant.topSpacing,
                                 width: (CGFloat(Int(Constant.screenWidth)) - CGFloat(Constant.horizontalSpacing * 2)), height: Constant.topRectHeight))
        self.setUISegmentedControlView()
        self.addSubview(getUISegmentedControlView())
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUISegmentedControlView(){
        uiSegmentControlView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: uiSegmentControlView.frame.height)//x:0, y:0으로 설정한 이유는 UISegmentedControl이 view를 부모 뷰에 상대적인 위치로 잡기 때문으로 이해했습니다.
    }
    func getUISegmentedControlView() -> UISegmentedControl{
        return uiSegmentControlView
    }
}
