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
    init(){
        super.init(frame: CGRect(x: (CGFloat(Constant.horizontalSpacing)),
                                 y : Constant.topSpacing,
                                 width: (CGFloat(Int(Constant.screenWidth)) - CGFloat(Constant.horizontalSpacing * 2)), height: Constant.topRectHeight))
        self.addSubview(getUISegmentedControlView())
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getUISegmentedControlView() -> UISegmentedControl{
        let uiSegmentControlView = UISegmentedControl(items: ["3명", "4명", "5명"])
        uiSegmentControlView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: uiSegmentControlView.frame.height)//x:0, y:0으로 설정한 이유는 UISegmentedControl이 view를 부모 뷰에 상대적인 위치로 잡기 때문으로 이해했습니다.
        uiSegmentControlView.selectedSegmentIndex = 0//처음에는 세명을 기본 선택으로 지정합니다.
        uiSegmentControlView.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        return uiSegmentControlView
    }
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl){
        if sender.selectedSegmentIndex == 0{//3명일때
            print("3명 선택했습니다")
        }else if sender.selectedSegmentIndex == 1{//4명일때
            print("4명 선택했습니다")
        }else if sender.selectedSegmentIndex == 2{//5명일때
            print("5명 선택했습니다")
        }
    }
}
