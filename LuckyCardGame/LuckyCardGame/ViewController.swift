//
//  ViewController.swift
//  LuckyCardGame
//
//  Created by Eunno An on 2023/07/03.
//

import UIKit

// MARK: - 기기의 height, width
let screenHeight = UIScreen.main.bounds.size.height
let screenWidth = UIScreen.main.bounds.size.width

class ViewController: UIViewController {
    
    // MARK: 상수정보
    struct Constant{
        static let topRectHeight:CGFloat = 44
        static let horizontalSpacing:CGFloat = 20
        static let topSpacing:CGFloat = 60
        static let bottomSpacing:CGFloat = 30
        static let spacing:CGFloat = 10
    }
    
    // MARK: Board의 공통 정보
    struct Board{
        static let height:CGFloat = CGFloat( screenHeight / 8) // board의 세로 길이
        static let width:CGFloat = CGFloat(screenWidth) - Constant.bottomSpacing // board의 가로 길이
        static let labels = ["A", "B", "C", "D", "E"] // board의 각 레이블
    }
    
    // MARK: 노란색 board의 정보
    private var rect_top: PlayerboardView = {
        let topboard = PlayerboardView(frame: CGRect(x: (CGFloat(Constant.horizontalSpacing)),
                                                     y : Constant.topSpacing,
                                                     width: (CGFloat(Int(screenWidth)) - CGFloat(Constant.horizontalSpacing * 2)),
                                                     height: Constant.topRectHeight),
                                       name: "")
        topboard.backgroundColor = .yellow
        return topboard
    }()
    
    private lazy var playerBoards: [PlayerboardView] = {
        let boards = ["A", "B", "C", "D", "E"].enumerated().map{ i, name in
            return PlayerboardView(frame:
                                    CGRect(x: (CGFloat(Constant.horizontalSpacing)),
                                        y: Constant.topSpacing + Constant.topRectHeight + Constant.spacing * CGFloat(i+1) + Board.height * CGFloat(i),
                                    width: CGFloat(screenWidth) - CGFloat(Constant.horizontalSpacing * 2),
                                        height: Board.height)
                                    ,
                                   name: name)
        }
        return boards
    }()
    
    // MARK: 중간 회색 board의 정보
    private lazy var rect_bottom: RoundBoardView = {
        
        let lastBoardHeight: CGFloat = CGFloat(screenHeight - (Constant.spacing * 6 + Board.height * 5 + Constant.topSpacing + Constant.topRectHeight) - Constant.bottomSpacing)
        
        let view = RoundBoardView(frame: CGRect(
            x: Constant.horizontalSpacing, y: Constant.topSpacing + Constant.topRectHeight + Constant.spacing + 5 * (Board.height + Constant.spacing), width: (screenWidth) - Constant.horizontalSpacing * 2, height: lastBoardHeight
        ))
        
        view.backgroundColor = .systemGray
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 카드 객체 인스턴스를 생성하는 곳에서 문자열로 콘솔에 출력하는 부분입니다.
        
        let deck = Deck()
        deck.setCards()
        Tester.printCardInfo(deck: deck)
        
        addsubview()
    }
    
    func addsubview(){
        let views = [rect_top, rect_bottom] + playerBoards
        views.forEach{
            self.view.addSubview($0)
        }
    }
    
}
