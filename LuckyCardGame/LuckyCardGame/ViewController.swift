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
    
    // MARK: Board의 공통 정보
    struct Board{
        static let height: CGFloat = screenHeight / 8 // board의 세로 길이
        static let width: CGFloat = screenWidth - 20 // board의 가로 길이
        static let labels = ["A", "B", "C", "D", "E"] // board의 각 레이블
        static let spacing: CGFloat = 10 // board 사이의 spacing
        static let radius: CGFloat = 10 // board의 corner radius값
    }
    
    // MARK: 노란색 board의 정보
    let rect_Top: UIView = {
        let rect = CGRect(x: 10, y: 60, width: Board.width, height: 44)
        let view = UIView(frame: rect)
        
        view.backgroundColor = .yellow
        view.layer.cornerRadius = Board.radius
        
        return view
    }()
    
    // MARK: 중간 회색 board의 정보
    let rect_Bottom: UIView = {
        let lastBoardHeight: CGFloat = screenHeight - (Board.spacing * 6 + Board.height * 5 + 60 + 44) - 30 // 마지막 보드의 길이 = 전체 길이 - (board사이의 간격 * 간격 개수 + board의 높이 * board 개수 + rect_Top의 height) - 맨 아래 spacing
        let rect = CGRect(x: 10, y: 114 + 5 * (Board.height + Board.spacing), width: Board.width, height: lastBoardHeight)
        let view = UIView(frame: rect)
        
        view.backgroundColor = .systemGray
        view.layer.cornerRadius = Board.radius
        
        return view
    }()
    
    // MARK: frame과 label을 받아서 보드를 반환하는 함수
    
    /// - Parameter frame : board의 CGRect정보
    /// - Parameter terminator :board의 label
    ///
    /// - returns : Board의 View 반환
    func createRectView(frame: CGRect, boardLabel: String) -> UIView {
        
        let view = UIView(frame: frame)
        
        view.backgroundColor = .systemGray5
        view.layer.cornerRadius = Board.radius
        
        let label = UILabel(frame: CGRect(x: 20, y: 0, width: view.bounds.width, height: view.bounds.height))
        
        label.text = boardLabel
        label.textAlignment = .left
        
        let descriptor = UIFont.systemFont(ofSize: 40, weight: .heavy).fontDescriptor
            .withSymbolicTraits([.traitBold, .traitItalic]) // 이탈릭체와 볼드체를 같이 쓸 때 사용하는 descriptor
        
        label.font = UIFont(descriptor: descriptor!, size: 40)
        
        label.textColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        
        label.sizeToFit()
        
        label.frame = CGRect(origin: label.frame.origin, size: CGSize(width: label.frame.width, height: view.frame.height))
        
        view.addSubview(label)
        
        return view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(rect_Top)
        
        for i in 0..<5{
            self.view.addSubview(createRectView(frame:  CGRect(x: 10, y: CGFloat(114 + Int((Board.height + Board.spacing)) * i), width: Board.width, height: Board.height), boardLabel: Board.labels[i]))
        }
        
        self.view.addSubview(rect_Bottom)
    }


}
