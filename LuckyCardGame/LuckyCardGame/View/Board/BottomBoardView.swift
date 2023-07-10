//
//  BottomBoardView.swift
//  LuckyCardGame
//
//  Created by Eunno An on 2023/07/08.
//

import Foundation

// MARK: GameView 하단에 카드를 놓는 BottomBoardView입니다.
class BottomBoardView : RoundBoardView{
    typealias CardSize = Constant.CardConstant
    
    //뒷면 카드 뷰를 초기화하는 부분입니다.
    private var behindCardViews: [BehindCardView] = {
        var views: [BehindCardView] = []
        let bottomBoardHeight: CGFloat = Board.height * 2
        let cardsByOneCol: Int = Int(ceil(CGFloat(RemainingCardNum.nine.rawValue) / CGFloat(BottomBoardOneRowCardNum.fiveCardsByOneRow .rawValue)))
        print(cardsByOneCol)
        
        var xPos: CGFloat = (Board.width - CardSize.width * CGFloat(BottomBoardOneRowCardNum.fiveCardsByOneRow.rawValue)) / CGFloat(BottomBoardOneRowCardNum.fiveCardsByOneRow.rawValue + 1)
        
        var yPos: CGFloat = (bottomBoardHeight - CardSize.height * CGFloat(cardsByOneCol)) / CGFloat(cardsByOneCol + 1)
        
        //9개를 5개마다 초기화 시켜야함.
        for i in 0..<RemainingCardNum.nine
            .rawValue{
            views.append(BehindCardView(frame: CGRect(x: xPos + (xPos + CardSize.width) * CGFloat(i % BottomBoardOneRowCardNum.fiveCardsByOneRow.rawValue), y:  yPos + (yPos + CardSize.height) * CGFloat(Int(i / BottomBoardOneRowCardNum.fiveCardsByOneRow.rawValue )), width: CardSize.width, height: CardSize.height)))
        }
        return views
    }()
    
    init(frame: CGRect){
        super.init(frame: frame)
        for backCardView in behindCardViews{
            self.addSubview(backCardView)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //TODO: 뷰 컨트롤러로 이 기능을 따로 뺴보기.
    public func setBottomCards(attendeeNum: AttendeeNum){
        for behindCardView in behindCardViews{
            behindCardView.removeFromSuperview()
        }
        
        let bottomBoardHeight: CGFloat = (attendeeNum == .five ? Board.height : Board.height * 2)
        for backCardView in behindCardViews{
            backCardView.removeFromSuperview()
        }
        var views: [BehindCardView] = []
        
        let cardNumInBottomBoard: RemainingCardNum = getRemainingCardNumByAttendeeNum(attendeeNum: attendeeNum)
        let cardsByOneRow: BottomBoardOneRowCardNum = getOneRowCardNumByAttendeeNum(attendeeNum: attendeeNum)
        let cardsByOneCol: Int = Int(ceil(CGFloat(cardNumInBottomBoard.rawValue) / CGFloat(cardsByOneRow.rawValue)))
        
        let xPos: CGFloat = (Board.width - CardSize.width * CGFloat(cardsByOneRow.rawValue)) / CGFloat(cardsByOneRow.rawValue + 1)
        let yPos: CGFloat = (bottomBoardHeight - CardSize.height * CGFloat(cardsByOneCol)) / CGFloat(cardsByOneCol + 1)
        
        for i in 0..<cardNumInBottomBoard.rawValue{
            views.append(BehindCardView(frame: CGRect(x: xPos + ((attendeeNum == .five ? 0 : xPos) + CardSize.width) * CGFloat(i % cardsByOneRow.rawValue), y: yPos + (yPos + CardSize.height) * CGFloat(Int(i / cardsByOneRow.rawValue)), width: CardSize.width, height: CardSize.height)))
        }
        
        behindCardViews = views
        
        for behindCardView in behindCardViews{
            self.addSubview(behindCardView)
        }
    }
    
    //TODO: 뷰 컨트롤러로 기능 따로 빼기
    private func getOneRowCardNumByAttendeeNum(attendeeNum: AttendeeNum) -> BottomBoardOneRowCardNum{
        switch attendeeNum{
        case .three:
            return BottomBoardOneRowCardNum.fiveCardsByOneRow
        case .four:
            return BottomBoardOneRowCardNum.fourCardsByOneRow
        case .five:
            return BottomBoardOneRowCardNum.sixCardsByOneRow
        }
    }
    
    //TODO: 뷰 컨트롤러로 기능 따로 뺴기
    private func getRemainingCardNumByAttendeeNum(attendeeNum: AttendeeNum) -> RemainingCardNum{
        switch attendeeNum{
        case .three:
            return RemainingCardNum.nine
        case .four:
            return RemainingCardNum.eight
        case .five:
            return RemainingCardNum.six
        }
    }
}
