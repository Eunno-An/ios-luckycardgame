//
//  PlayerboardView.swift
//  LuckyCardGame
//
//  Created by Eunno An on 2023/07/04.
//

import UIKit

class PlayerboardView: RoundBoardView{
    
    private lazy var playerName: UILabel = {
        let label = UILabel()
        label.text = "A"
        label.textColor = .gray.withAlphaComponent(0.5)
        let descriptor = UIFont.systemFont(ofSize: 50).fontDescriptor
                    .withSymbolicTraits([.traitBold, .traitItalic]) // Combine bold and italic traits
        label.font = UIFont(descriptor: descriptor!, size: 50)
        return label
    }()
    
    init(frame: CGRect, name: String)
    {
        super.init(frame: frame)
        playerName.text = name
        addsubView()
        configureView()
    }
    
    required init?(coder: NSCoder){
        fatalError("init(coder:) has not been implemented ")
    }
    
    private func configureView(){
        backgroundColor = .systemGray5
    }
    
    private func addsubView(){
        self.addSubview(playerName)
        playerName.sizeToFit()
        playerName.frame = CGRect(x: 10, y: 0, width: playerName.frame.width, height: self.frame.height)
    }
    
}
