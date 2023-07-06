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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(SegmentedControlView())
    }
}
