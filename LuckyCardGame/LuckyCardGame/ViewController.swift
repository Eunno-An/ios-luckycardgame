//
//  ViewController.swift
//  LuckyCardGame
//
//  Created by Eunno An on 2023/07/03.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let segmentedControlView = SegmentedControlView()
        let segmentedControl = segmentedControlView.getUISegmentedControlView()
        self.view.addSubview(segmentedControlView)
        segmentedControl.selectedSegmentIndex =  0//처음에는 세명을 기본 선택으로 지정합니다.
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        
        self.view.addSubview(GameView())
    }
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl){
        switch sender.selectedSegmentIndex{
        case 0:
            print("3명 선택했습니다")
        case 1:
            print("4명 선택했습니다")
        case 2:
            print("5명 선택했습니다")
        default:
            print("OOps")
        }
        
    }
}
