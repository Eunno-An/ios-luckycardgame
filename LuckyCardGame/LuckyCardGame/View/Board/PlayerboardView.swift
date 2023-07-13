//
//  PlayerboardView.swift
//  LuckyCardGame
//
//  Created by Eunno An on 2023/07/04.
//

import UIKit

class PlayerboardView: RoundBoardView{
    typealias CardSize = Constant.CardConstant
    private lazy var playerName: UILabel = {
        let label = UILabel()
        label.text = "A"
        label.textColor = .gray.withAlphaComponent(0.5)
        let descriptor = UIFont.systemFont(ofSize: 50).fontDescriptor
                    .withSymbolicTraits([.traitBold, .traitItalic]) // Combine bold and italic traits
        label.font = UIFont(descriptor: descriptor!, size: 50)
        return label
    }()
    
    /*
     MARK: PlayerBoardView에 담길 [CardView]를 표현하는 부분입니다.
     x좌표를 방정식으로 계산하였습니다
     */
    private var cardViews: [CardView] = {
        var views: [FrontCardView] = []
        var xPos: CGFloat = (Board.width - Constant.spacing * 2 - CardSize.width) / CGFloat(AttendeeCardNum.threeAttendeeHave.rawValue - 1)
        for i in 0..<AttendeeCardNum.threeAttendeeHave.rawValue{
            views.append(FrontCardView(frame: CGRect(x: Constant.spacing/2 + xPos * CGFloat(i), y: Constant.spacing, width: CardSize.width, height: CardSize.height), cardAnimal: Animal.dog, cardNumber: CardNumber.one))
        }
        return views
    }()
    
    init(frame: CGRect, name: String)
    {
        super.init(frame: frame)
        playerName.text = name
        if name == "A"{
            addMyBoardView()
        }else{
            addOtherBoardView()
        }
        configureView()
    }
    
    required init?(coder: NSCoder){
        fatalError("init(coder:) has not been implemented ")
    }
    
    private func configureView(){
        backgroundColor = .systemGray5
    }
    
    //나의 보드를 표시하는 부분입니다.
    private func addMyBoardView(){
        for cardView in cardViews{
            self.addSubview(cardView)
        }
        layer.borderWidth = 3
        layer.borderColor = UIColor.label.cgColor
    }
    
    //다른 플레이어의 보드를 표시하는 부분입니다.
    private func addOtherBoardView(){
        self.addSubview(playerName)
        playerName.sizeToFit()
        playerName.frame = CGRect(x: 10, y: 0, width: playerName.frame.width, height: self.frame.height)
    }
    
    //PlayerBoard안에서 각각 카드의 x좌표에 대한 방정식입니다.
    public func calFirstCard_xPos(attendeeCardNum: AttendeeCardNum) -> CGFloat{
        return (Board.width - Constant.spacing * 2 - CardSize.width) / CGFloat(attendeeCardNum.rawValue - 1)
    }
    
    //x번째의 플레이어의 카드들을 설정하는 함수입니다.
    ///- Parameter attendeeCardnum: 참가자가 갖고 있는 카드 개수
    ///- Parameter deck: 참가자가 갖고 있는 카드 덱
    ///- Parameter attendeeIdx: 참가자의 인덱스
    public func setCardsInXthPlayerBoard(attendeeCardNum: AttendeeCardNum, deck: Deck, attendeeIdx: Int){
        for cardView in cardViews{
            cardView.removeFromSuperview()
        }
        
        var views: [CardView] = []
        let xPos: CGFloat = calFirstCard_xPos(attendeeCardNum: attendeeCardNum)
        if attendeeIdx == 0{
            for i in 0..<attendeeCardNum.rawValue{
                views.append( FrontCardView(frame: CGRect(x: Constant.spacing + xPos * CGFloat(i), y: Constant.spacing, width: CardSize.width, height: CardSize.height), cardAnimal: deck.cards[i].animal, cardNumber: deck.cards[i].number))
            }
        }else{
            for i in 0..<attendeeCardNum.rawValue{
                views.append( BehindCardView(frame: CGRect(x: Constant.spacing + xPos * CGFloat(i), y: Constant.spacing, width: CardSize.width, height: CardSize.height)))
            }
        }
        
        for cardView in views{
            self.addSubview(cardView)
        }
        
        self.cardViews = views
    }
}
