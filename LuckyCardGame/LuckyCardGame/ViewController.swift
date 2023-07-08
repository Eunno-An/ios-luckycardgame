//
//  ViewController.swift
//  LuckyCardGame
//
//  Created by Eunno An on 2023/07/03.
//

import UIKit

class ViewController: UIViewController {
    
    private var luckyCardGame: LuckyCardGame
    private var gameView: GameView?
    init(){
        self.luckyCardGame = LuckyCardGame()
        super.init(nibName: nil, bundle: nil)
    }
    
    init(luckyCardGame: LuckyCardGame){
        self.luckyCardGame = luckyCardGame
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.luckyCardGame = LuckyCardGame()
        self.luckyCardGame.gameStart(attendeeNum: .three)
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let segmentedControlView = SegmentedControlView()
        let segmentedControl = segmentedControlView.getUISegmentedControlView()
        self.view.addSubview(segmentedControlView)
        segmentedControl.selectedSegmentIndex = 0//처음에는 세명을 기본 선택으로 지정합니다.
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        gameView = GameView(luckyCardGame: self.luckyCardGame)
        self.view.addSubview(gameView ?? GameView(luckyCardGame: self.luckyCardGame))
    }
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl){
        switch sender.selectedSegmentIndex{
        case 0:
            luckyCardGame.gameStart(attendeeNum: .three)//gameStart
        case 1:
            luckyCardGame.gameStart(attendeeNum: .four)//gameStart
        case 2:
            luckyCardGame.gameStart(attendeeNum: .five)//gameStart
        default:
            print("Oops, segmentedControlValueChanged has error!")
        }
        gameView?.removeFromSuperview()
        gameView = GameView(luckyCardGame: self.luckyCardGame)
        self.view.addSubview(gameView!)
    }
}
