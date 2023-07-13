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
        drawDeckForAllBoards(attendeeNum: .three)
        self.view.addSubview(gameView ?? GameView())
    }
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl){
        gameView?.removeFromSuperview()
        
        switch sender.selectedSegmentIndex{
        case 0:
            luckyCardGame.gameStart(attendeeNum: .three)//gameStart
            gameView?.setOtherPlayerBoardViews(playerBoardViews: calculatePlayerBoards(numOfAttendee: .three))//나를 제외한 '다를 플레이어'보드를 초기화
            drawDeckForAllBoards(attendeeNum: .three)
            gameView?.bottomBoardView.setBottomCards(attendeeNum: .three)//bottomBoard에 있는 카드들을 다시 그림
            
        case 1:
            luckyCardGame.gameStart(attendeeNum: .four)//gameStart
            gameView?.setOtherPlayerBoardViews(playerBoardViews: calculatePlayerBoards(numOfAttendee: .four))
            drawDeckForAllBoards(attendeeNum: .four)
            gameView?.bottomBoardView.setBottomCards(attendeeNum: .four)
        case 2:
            luckyCardGame.gameStart(attendeeNum: .five)//gameStart
            gameView?.setOtherPlayerBoardViews(playerBoardViews: calculatePlayerBoards(numOfAttendee: .five))
            drawDeckForAllBoards(attendeeNum: .five)
            gameView?.bottomBoardView.setBottomCards(attendeeNum: .five)
            
        default:
            print("Oops, segmentedControlValueChanged has error!")
        }
        gameView?.setMyPlayerBoardViews(myBoardView: (gameView?.playerBoardViews.first)!)//내 플레이어 보드를 다시 그림
        
        gameView?.setBottomBoardViewFrame(frame: calculateBottomFrame())//bottomBoard의 프레임 재지정
        
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
    
    //초기 뷰를 그리는 함수입니다.
    ///- Parameter attendeeNum: 참가자 수 입니다.
    func drawDeckForAllBoards(attendeeNum: AttendeeNum){
        for attendeeIdx in 0..<attendeeNum.rawValue{
            gameView?.playerBoardViews[attendeeIdx].setCardsInXthPlayerBoard(attendeeCardNum: .getAttendeeCardNum(attendeeNum: attendeeNum), deck: luckyCardGame.attendees[attendeeIdx].deck, attendeeIdx: attendeeIdx)//나의 플레이어 보드에 있는 카드들을 다시 그림
        }
    }
}
