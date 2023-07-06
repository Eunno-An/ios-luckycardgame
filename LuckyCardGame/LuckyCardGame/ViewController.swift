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
        
    }
    
}
