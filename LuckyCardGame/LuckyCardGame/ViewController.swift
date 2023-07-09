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
        gameView = GameView()
        self.view.addSubview(gameView ?? GameView())
    }
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl){
        gameView?.removeFromSuperview()
        
        switch sender.selectedSegmentIndex{
        case 0:
            luckyCardGame.gameStart(attendeeNum: .three)//gameStart
            gameView?.setPlayerBoardViews(playerBoardViews: calculatePlayerBoards(numOfAttendee: .three))
        case 1:
            luckyCardGame.gameStart(attendeeNum: .four)//gameStart
            gameView?.setPlayerBoardViews(playerBoardViews: calculatePlayerBoards(numOfAttendee: .four))
        case 2:
            luckyCardGame.gameStart(attendeeNum: .five)//gameStart
            gameView?.setPlayerBoardViews(playerBoardViews: calculatePlayerBoards(numOfAttendee: .five))
        default:
            print("Oops, segmentedControlValueChanged has error!")
        }
        
        gameView?.setBottomBoardViewFrame(frame: calculateBottomFrame())
        
        self.view.addSubview(gameView!)
    }
    
    //LuckyCardGame.belowLuckyCards가 담길 공간을 표시하는 bottomBoardView
    func calculateBottomFrame() -> CGRect{
        
        let numOfAttendee: Int = luckyCardGame.getNumOfAttendee()
        let lastBoardWidth: CGFloat = Constant.screenWidth - Constant.horizontalSpacing * 2
        
        var yPos: CGFloat = 0
        var lastBoardHeight: CGFloat = 0
        
        if numOfAttendee == 5{
            yPos = 5 * (Board.height + Constant.spacing)
            lastBoardHeight = Board.height
        }
        else if numOfAttendee == 3 || numOfAttendee == 4{//참가자가 3명 또는 4명일 때
            yPos = 4 * (Board.height + Constant.spacing)
            lastBoardHeight = Board.height * 2
        }
        
        let frame = CGRect(
            x: 0, y: yPos, width: lastBoardWidth, height: lastBoardHeight
        )
        
        return frame
    }
    
    func calculatePlayerBoards(numOfAttendee: AttendeeNum) -> [PlayerboardView]{
        var views: [PlayerboardView] = []
        for i in 1...numOfAttendee.rawValue{
            views.append(PlayerboardView(frame:
                                            CGRect(x: 0,
                                                y:  Constant.spacing * CGFloat(i-1) + Board.height * CGFloat(i-1),
                                                   width: CGFloat(Constant.screenWidth) - CGFloat(Constant.horizontalSpacing * 2),
                                                   height: Board.height), name: Board.labels[i-1]))
        }
        return views
    }
    
}
