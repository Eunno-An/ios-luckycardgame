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
    private var cardViews: [FrontCardView] = {
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
        layer.borderColor = UIColor.blue.cgColor
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
    
    public func setMyCardView(attendeeCardNum: AttendeeCardNum, deck: Deck){
        for cardView in cardViews{
            cardView.removeFromSuperview()
        }
        var views: [FrontCardView] = []
        let xPos: CGFloat = (Board.width - Constant.spacing * 2 - CardSize.width) / CGFloat(attendeeCardNum.rawValue - 1)
        for i in 0..<attendeeCardNum.rawValue{
            views.append(FrontCardView(frame: CGRect(x: Constant.spacing/2 + xPos * CGFloat(i), y: Constant.spacing, width: CardSize.width, height: CardSize.height), cardAnimal: deck.getCards()[i].animal, cardNumber: deck.getCards()[i].number))
        }
       
        for cardView in views{
            self.addSubview(cardView)
        }
        self.cardViews = views
    }
}
